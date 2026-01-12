import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/interceptor.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

class HCApi {
  static final Dio _dio = Dio();
  static Dio get dio => _dio;
  static Future<String?> Function()? _refreshAccessToken;
  static Future<String?> Function()? get refreshAccessToken =>
      _refreshAccessToken;

  static void initialize({
    required String baseUrl,
    Map<String, dynamic>? headers,
    // * Future<String?> Function()? refreshAccessToken
    // * refreshToken을 App레벨에서 얻고, 콜백으로 전달 받아야 함.
    // ** return 값은 String? 또는 Exception을 발생시켜야 함.
    Future<String?> Function()? refreshAccessToken,
  }) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 15),
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

    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: Logger().e,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 5),
          Duration(seconds: 5),
          Duration(seconds: 5),
        ],
      ),
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

  // Update Access Token
  static void setAccessToken(String accessToken) {
    _dio.options.headers.addAll({'Authorization': 'Bearer $accessToken'});
  }

  // post 메소드 추가
  static Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    String? contentType,
  }) async {
    return _dio.post(
      path,
      data: data,
      options: Options(
        headers: headers,
        contentType: contentType,
      ),
    );
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
