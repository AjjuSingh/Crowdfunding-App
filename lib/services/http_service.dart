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
  late Response _response;
  late Dio dio;

  /// Development backend URL
  final String _baseUrl = "http://localhost:5000";

  /// In production backend URL
  final String _prodUrl = "https://aqueous-earth-15157.herokuapp.com";

  /// Init method to create instance of Dio
  void init() {
    // Base options
    BaseOptions options = new BaseOptions(
      baseUrl: _prodUrl,
    );
    dio = new Dio(options);
  }

  /// Build headers
  Map _buildHeaders({String? authToken}) {
    Map<String, String> headers = Map();
    headers["Content-Type"] = "application/json";
    if (authToken != null) {
      headers["Authorization"] = "Bearer $authToken";
    }
    return headers;
  }

  String _buildUrl({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) {
    var apiUrl = Uri.parse(_baseUrl);
    String apiPath = apiUrl.path + "/" + endpoint;
    final url = Uri(
            scheme: apiUrl.scheme,
            host: apiUrl.host,
            path: apiPath,
            queryParameters: queryParams)
        .toString();
    return url;
  }

  Future<dynamic> get({
    String? url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      // TODO: Get user token from shared preference

      // TODO: Pass token to _buildHeaders method

      Response response =
          await dio.get(url!, queryParameters: queryParams, options: Options());
      return response;
    } catch (_) {}
  }

  Future<Dio> getApiClient() async {
    PreferenceStore store = await PreferenceStore.create();
    var token = store.getToken;
    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          // Do something before request is sent
          options.headers["Authorization"] = "Bearer " + token!;
        },
        onResponse: (Response response, ResponseInterceptorHandler) {},
        onError:
            (DioError error, ErrorInterceptorHandler interceptorHandler) async {
          // Do something with response error
          if (error.response?.statusCode == 403) {
            dio.interceptors.requestLock.lock();
            dio.interceptors.responseLock.lock();
            // RequestOptions options = error.response.request;
            // FirebaseUser user = await FirebaseAuth.instance.currentUser();
            // token = await user.getIdToken(refresh: true);
            // await writeAuthKey(token);

            dio.interceptors.requestLock.unlock();
            dio.interceptors.responseLock.unlock();
          }
        }));
    dio.options.baseUrl = _baseUrl;
    return dio;
  }
}
