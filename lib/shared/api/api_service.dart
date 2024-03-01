import 'dart:convert';

import 'package:holopop/shared/config/appsettings.dart';
import 'package:holopop/shared/monads/result.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:http/http.dart' as http;

class SimplePostRequest {
  final String resource;
  final dynamic body;
  final String? contentType;

  SimplePostRequest({
    required this.resource,
    this.body,
    this.contentType});
}

class SimpleGetRequest {
  final String resource;
  final String? contentType;

  SimpleGetRequest({
    required this.resource,
    this.contentType
  });
}

class ApiService {
  final String host = "${AppSettings().getApiHost()}/";

  Future<Result<String>> getTokenAsync() async {
    final token = await UserPreferences().getTokenAsync();
    if (token != null) {
      return Result.fromSuccess(token);
    }

    return Result.fromFailure("API token is not saved.");
  }

  Future<Result<Map<String, dynamic>>> post(SimplePostRequest request) async {
    final tokenRes = await getTokenAsync();
    if (tokenRes.success == false) {
      return Result.fromFailure(tokenRes.error!);
    }

    final headers = { 
      'Authorization': 'Bearer ${tokenRes.value}'
    };
    if (request.contentType != null) {
      headers.addAll({ 'Content-Type': request.contentType! });
    }

    try {
      final res = await http.post(
        Uri.parse(host + request.resource),
        body: json.encode(request.body),
        headers: headers);

      final data = json.decode(res.body);
      switch (res.statusCode) {
        case 200:
          return Result.fromSuccess(data);
        default:
          return Result.fromFailure(res.reasonPhrase ?? "API request failed: $data");
      }
    } on Exception catch (e) {
      return Result.fromFailure(e as String);
    }
  }

  Future<Result<dynamic>> get(SimpleGetRequest request) async {
    final tokenRes = await getTokenAsync();
    if (tokenRes.success == false) {
      return Result.fromFailure(tokenRes.error!);
    }

    try {
      final headers = { 
        'Authorization': 'Bearer ${tokenRes.value}'
      };

      if (request.contentType != null) {
        headers.addAll({'Content-Type': request.contentType!});
      }

      final res = await http.get(
        Uri.parse(host + request.resource),
        headers: headers);

      final data = json.decode(res.body);
      switch (res.statusCode) {
        case 200:
          return Result.fromSuccess(data);
        default:
          return Result.fromFailure(res.reasonPhrase ?? "API request failed: $data");
      }
    } on Exception catch (e) {
      return Result.fromFailure(e as String);
    }
  } 
}