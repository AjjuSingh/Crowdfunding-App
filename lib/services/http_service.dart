import 'package:dio/dio.dart';

import 'native_http_service.dart';

class HttpFactory {
  static HttpService create() {
    HttpService service = NativeHttpService();
    return service;
  }
}

abstract class HttpService {
  /// /////////////////////////////////////////////////
  /// Concrete Methods
  /// //////////////////////////////////////////////////

  // shared setUserId method
  String? _userId;
  String get userId => _userId!;
  set userId(String value) => _userId = value;

  late Response _response;
  Dio dio = new Dio();

  initInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (Options option) {
      dio.interceptors.requestLock.lock();
    }));
  }

  /// Define get, post, patch, update methods
  Future<Response> get(
      {String? endpoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    return _response;
  }
}
