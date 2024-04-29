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

  // 401 오류 연속 발생 횟수 추적
  static int _401count = 0;

  static void initialize({
    required String baseUrl,
    Map<String, dynamic>? headers,
    Future<String> Function()? refreshAccessToken,
  }) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers ?? {}, // 헤더 추가
      followRedirects: false,
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

  static Future<String> refreshToken() async {
    try {
      final refreshToken = await HCDB.getRefreshToken();
      final authId = await HCDB.getAuthId();

      if (refreshToken == null || authId == null) {
        throw Exception('No refreshToken or authId available');
      }

      final response = await post(
        '/api/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
        headers: {}, // 헤더를 비운다.
      );

      if (response.statusCode == 200 && response.data['retCd'] == 0) {
        final tokensData = response.data['data'];
        await HCDB.saveTokens(
          accessToken: tokensData['accessToken'],
          refreshToken: tokensData['refreshToken'],
        );
        Logger().d('토큰을 갱신하였습니다. : ${tokensData['accessToken']}');
        return tokensData['accessToken'];
      } else if (response.data['retCd'] == 2) {
        Logger().e('Invalid Token: 인증되지 않은 토큰');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badCertificate,
        );
      } else if (response.data['retCd'] == 3) {
        Logger().e('Expired Refresh Token: 리프레시 토큰 만료');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badCertificate,
        );
      } else {
        Logger().e('Bad Response: ${response.data}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      print('Refresh Token Error: $e');
      rethrow;
    }
  }
}
