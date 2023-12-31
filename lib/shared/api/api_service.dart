import 'dart:convert';

import 'package:holopop/shared/api/api_response.dart';
import 'package:holopop/shared/config/appsettings.dart';
import 'package:http/http.dart' as http;

class SimplePostRequest {
  final String resource;
  final dynamic body;

  SimplePostRequest({required this.resource, required this.body});
}

class ApiService {
  /// TODO: put somewhere better
  final String host = "${AppSettings().getApiHost()}/";

  Future<APIResponse> post(SimplePostRequest request) async {
    final res = await http.post(
      Uri.parse(host + request.resource),
      body: json.encode(request.body),
      headers: {'Content-Type': 'application/json'}
    );

    final data = json.decode(res.body);
    if (res.statusCode == 200) {  //TODO make better
      return APIResponseData.fromJson(data);
    } else {
      return APIResponseError.fromJson(data);
    }
  }
}