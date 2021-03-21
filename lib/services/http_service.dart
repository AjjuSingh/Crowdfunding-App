import 'package:dio/dio.dart';

import 'native_http_service.dart';

class HttpFactory {
  static HttpService create() {
    HttpService service = NativeHttpService();
    return service;
  }
}

abstract class HttpService {
  /////////////////////////////////////////////////////////
  /// Dio http client setup
  /// Base options and other stuff 👍
  /////////////////////////////////////////////////////////
  late Response _response;
  late Dio dio;
  final String _baseUrl = "http://localhost:5000";

  /// Init method to create instance of Dio
  void init() {
    // Base options
    BaseOptions options = new BaseOptions(
      baseUrl: "http://localhost:5000",
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
}
