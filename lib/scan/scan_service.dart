import 'package:holopop/shared/api/api_service.dart';
import 'package:holopop/shared/monads/result.dart';

class ScanService {
  static Future<Result<String>> scanCard(String serialNumber) => 
    ApiService()
      .post(
        SimplePostRequest(
          resource: "/user/scan",
          body: { "serialnumber": serialNumber}), 
        (data) => data["serialNumber"]);
}