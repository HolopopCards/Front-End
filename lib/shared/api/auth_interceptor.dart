import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract {

  @override
  Future<bool> shouldInterceptRequest() {
    // TODO: implement shouldInterceptRequest
    throw UnimplementedError();
  }

  @override
  Future<bool> shouldInterceptResponse() {
    // TODO: implement shouldInterceptResponse
    throw UnimplementedError();
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) {
    // TODO: implement interceptRequest
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) {
    // TODO: implement interceptResponse
    throw UnimplementedError();
  }
}