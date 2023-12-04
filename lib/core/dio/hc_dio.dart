import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/interceptor.dart';
import 'package:hcm_core/core/hive/hc_hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HCDio {
  static final Dio _dio = Dio();

  // 임시적으로 사용하는 fcm 토큰
  static const String temp_token =
      "dKpI6DSWSLyVFx8UE6QDRQ:APA91bETqIZq1qz3Y5-gHsDHx3kL1VHU2rY0FRrW13NtP5yOzaMo9S9yiF_TYTVSEMmF54F3DxavJRimMVDXoLQYUSzMgTUl6H2CEWeASg4VJjjs0bXLvDRiHilsSOYsaqs73-dFU0we";

  static void initialize(
      {required String baseUrl, Map<String, dynamic>? headers}) {
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
      final refreshToken = await HCHive.getRefreshToken();
      final authId = await HCHive.getAuthId();
      final userSno = await HCHive.getUserSno();

      if (refreshToken == null || authId == null) {
        throw Exception('No refreshToken or authId available');
      }

      final response = await post(
        '/api/auth/access-token',
        data: {
          'authId': authId,
          'refreshToken': refreshToken,
          'userSno': userSno,
        },
        headers: {}, // 헤더를 비운다.
      );

      if (response.statusCode == 200 && response.data['retCd'] == '0') {
        final tokensData = response.data['data'];
        await HCHive.saveTokens(
          accessToken: tokensData['accessToken'],
          refreshToken: tokensData['refreshToken'],
        );
        return tokensData['accessToken'];
      } else {
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
