import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/interceptor.dart';
import 'package:hcm_core/core/hive/hc_db.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HCApi {
  static final Dio _dio = Dio();
  static Dio get dio => _dio;
  static Future<String> Function()? _refreshAccessToken;
  static Future<String> Function()? get refreshAccessToken =>
      _refreshAccessToken;

  /// TODO 401 오류 연속 발생 횟수 추적
  static int _401count = 0;

  static void initialize({
    required String baseUrl,
    Map<String, dynamic>? headers,
    Future<String> Function()? refreshAccessToken,
  }) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers ?? {}, // 헤더 추가
    );
    _dio.interceptors.add(CustomInterceptor());
    _dio.interceptors.add(
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: false,
          maxWidth: 90),
    );
    _refreshAccessToken = refreshAccessToken;
  }

  static void refreshHeader() {
    _dio.options.headers.clear();
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  /// Update Access Token
  static void setAccessToken(String accessToken) {
    _dio.options.headers.addAll({'Authorization': 'Bearer $accessToken'});
  }

  // post 메소드 추가
  static Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? headers}) async {
    return _dio.post(path, data: data, options: Options(headers: headers));
  }

  // get 메소드 추가
  static Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  // delete 메소드 추가
  static Future<Response> delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  // fetch 메소드 추가
  static Future<Response> fetch(RequestOptions requestOptions) {
    return _dio.fetch(requestOptions);
  }
}
