import 'dart:convert';

import 'package:crowdfund_app/caching/app_shared_preferences_caching.dart';
import 'package:dio/dio.dart';

import 'native_http_service.dart';

class HttpFactory {
  static HttpService create() {
    HttpService service = NativeHttpService();
    return service;
  }
}

abstract class HttpService {
  /// Dio http client setup
  /// Base options and other stuff 👍
  late Dio dio;

  /// Development backend URL
  final String _baseUrl = "http://localhost:5000";

  /// In production backend URL
  final String _prodUrl = "https://aqueous-earth-15157.herokuapp.com";

  /// Init method to create instance of Dio
  void init() async {
    PreferenceStore preferenceStore = await PreferenceStore.create();
    String token = preferenceStore.getToken!;

    // Base options
    BaseOptions options = new BaseOptions(baseUrl: _prodUrl, headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });
    dio = new Dio(options);
  }

  Future<dynamic> get({
    String? url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await dio.get(url!,
          queryParameters: queryParams,
          options: Options(contentType: "application/json"));
      var decodedResponse = jsonDecode(response.data);
      return decodedResponse;
    } catch (_) {}
  }

  Future<dynamic> post({
    String? url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await dio.post(url!,
          data: queryParams, options: Options(contentType: "application/json"));
      var decodedResponse = jsonDecode(response.data);
      return decodedResponse;
    } catch (_) {}
  }
}
