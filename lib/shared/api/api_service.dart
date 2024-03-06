import 'dart:convert';

import 'package:holopop/shared/api/api_response.dart';
import 'package:holopop/shared/config/appsettings.dart';
import 'package:holopop/shared/monads/result.dart';
import 'package:holopop/shared/providers/auth_provider.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

// TODO: Move these to better place.
class SimplePostRequest {
  final String resource;
  final dynamic body;
  final String contentType;

  SimplePostRequest({
    required this.resource,
    this.body,
    this.contentType = "application/json"});

  @override
  String toString() => "Simple Post Model => $resource|$contentType|$body";
}

class FilePostRequest {
  final String resource;
  final List<http.MultipartFile> files;
  final String contentType;

  FilePostRequest({
    required this.resource,
    required this.files,
    required this.contentType});

    @override
    String toString() => "File Post Model => $resource|${files.length}|$contentType";
}

class SimpleGetRequest {
  final String resource;
  final String contentType;

  SimpleGetRequest({
    required this.resource,
    this.contentType = "application/json"});

  @override
  String toString() => "Simple Get Model => $resource|$contentType";
}

class ApiService {
  final String host = AppSettings().getApiHost();

  Future<Result<String>> getTokenAsync() async {
    final token = await UserPreferences().getAccessTokenAsync();
    if (token != null) {
      return Result.fromSuccess(token);
    }

    return Result.fromFailure("API token is not saved.");
  }

  Future<Result<T>> post<T>(SimplePostRequest request, T Function(dynamic) mapper, { bool isARetry = false }) async {
    Logger('api service').fine("Sending post request: $request");
    final tokenRes = await getTokenAsync();
    if (tokenRes.success == false) {
      return Result.fromFailure(tokenRes.error!);
    }

    try {
      final headers = { 
        'Authorization': 'Bearer ${tokenRes.value}'
      };

      headers.addAll({ 'Content-Type': request.contentType });

      final httpResponse = await http.post(
        Uri.parse(host + request.resource),
        body: json.encode(request.body),
        headers: headers);

      Logger('api service').info("Simple post response code for ${request.resource}: ${httpResponse.statusCode}");
      Logger('api service').fine("Body from post response ${request.resource}: ${httpResponse.body}");

      if (httpResponse.statusCode == 401 && isARetry == false) {
        await AuthProvider().refresh();
        return post(request, mapper, isARetry: true);
      }

      final data = json.decode(httpResponse.body);

      ApiResponse apiResponse = data["error"] != null  // If there is an error property, it's a failed API process
        ? APIResponseError.fromJson(data) 
        : APIResponseData.fromJson(data);

      if (apiResponse is APIResponseData) {
        return Result.fromSuccess(mapper(apiResponse.data));
      } else {
        return Result.fromFailure(httpResponse.reasonPhrase ?? "API request failed: $data");
      }
    } on Exception catch (e) {
      return Result.fromFailure(e as String);
    }
  }
  
  Future<Result<T>> postFile<T>(FilePostRequest request, T Function(dynamic) mapper, { bool isARetry = false }) async {
    Logger('api service').fine("Sending file post request: $request");
    final tokenRes = await getTokenAsync();
    if (tokenRes.success == false) {
      return Result.fromFailure(tokenRes.error!);
    }

    try {
      final httpRequest = http.MultipartRequest('POST', Uri.parse(host + request.resource));
      httpRequest.files.addAll(request.files);
      httpRequest.headers.addAll({ 
        'Authorization': 'Bearer ${tokenRes.value}',
        'Content-Type': request.contentType});
      final httpResponse = await httpRequest.send();

      Logger('api service').info("File post response code for ${request.resource}: ${httpResponse.statusCode}");

      if (httpResponse.statusCode == 401 && isARetry == false) {
        await AuthProvider().refresh();
        return postFile(request, mapper, isARetry: true);
      }

      final data = json.decode(await httpResponse.stream.bytesToString());

      ApiResponse apiResponse = data["error"] != null  // If there is an error property, it's a failed API process
        ? APIResponseError.fromJson(data) 
        : APIResponseData.fromJson(data);

      if (apiResponse is APIResponseData) {
        return Result.fromSuccess(mapper(apiResponse.data));
      } else {
        return Result.fromFailure(httpResponse.reasonPhrase ?? "API request failed: $data");
      }
    } on Exception catch (e) {
      return Result.fromFailure(e as String);
    }
  }

  Future<Result<T>> get<T>(SimpleGetRequest request, T Function(dynamic) mapper, { bool isARetry = false }) async {
    Logger('api service').fine("Sending get request: $request");
    final tokenRes = await getTokenAsync();
    if (tokenRes.success == false) {
      return Result.fromFailure(tokenRes.error!);
    }

    try {
      final headers = { 
        'Authorization': 'Bearer ${tokenRes.value}'
      };

      headers.addAll({'Content-Type': request.contentType});

      final httpResponse = await http.get(
        Uri.parse(host + request.resource),
        headers: headers);

      Logger('api service').info("Simple get response code for ${request.resource}: ${httpResponse.statusCode}");
      Logger('api service').fine("Body from get response ${request.resource}: ${httpResponse.body}");

      if (httpResponse.statusCode == 401 && isARetry == false) {
        await AuthProvider().refresh();
        return get(request, mapper, isARetry: true);
      }

      final data = jsonDecode(httpResponse.body) as Map<String, dynamic>;

      ApiResponse apiResponse = data["error"] != null  // If there is an error property, it's a failed API process
        ? APIResponseError.fromJson(data) 
        : APIResponseData.fromJson(data);

      if (apiResponse is APIResponseData) {
        return Result.fromSuccess(mapper(apiResponse.data));
      } else {
        return Result.fromFailure(httpResponse.reasonPhrase ?? "API request failed: $data");
      }
    } on Exception catch (e) {
      return Result.fromFailure(e as String);
    }
  } 
}