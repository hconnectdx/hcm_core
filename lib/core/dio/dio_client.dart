import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/interceptor.dart';
import 'package:hcm_core/utils/hive_manager/hive_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio;
  final String token =
      "dKpI6DSWSLyVFx8UE6QDRQ:APA91bETqIZq1qz3Y5-gHsDHx3kL1VHU2rY0FRrW13NtP5yOzaMo9S9yiF_TYTVSEMmF54F3DxavJRimMVDXoLQYUSzMgTUl6H2CEWeASg4VJjjs0bXLvDRiHilsSOYsaqs73-dFU0we";

  static final DioClient _instance = DioClient._internal();

  DioClient._internal() : _dio = Dio() {
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

  factory DioClient() {
    return _instance;
  }

  void initialize({required String baseUrl}) {
    _instance._dio.options = BaseOptions(baseUrl: baseUrl);
    // if (tokenManager != null) {
    //   _instance._dio.interceptors
    //       .removeWhere((interceptor) => interceptor is CustomInterceptor);
    //   _instance._dio.interceptors.add(CustomInterceptor());
    // }
  }

  // post 메소드 추가
  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? headers}) async {
    return _dio.post(path, data: data, options: Options(headers: headers));
  }

  // fetch 메소드 추가
  Future<Response> fetch(RequestOptions requestOptions) {
    return _dio.fetch(requestOptions);
  }

  Future<String> refreshToken() async {
    try {
      final refreshToken = await HiveTokenManager().getRefreshToken();
      final authId = await HiveTokenManager().getAuthId();
      final userSno = await HiveTokenManager().getUserSno();

      if (refreshToken == null || authId == null) {
        throw Exception('No refreshToken or authId available');
      }

      final response = await DioClient().post(
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
        await HiveTokenManager().saveTokens(
          tokensData['accessToken'],
          tokensData['refreshToken'],
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
