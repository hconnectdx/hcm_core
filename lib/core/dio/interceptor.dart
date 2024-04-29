import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core/core/dio/model/response.dart';
import 'package:logger/logger.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('login')) {
      HCApi.refreshHeader();
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger().e(err);
    final apiException = APIException(error: err);
    final response = apiException.response;

    if (response == null) {
      throw APIException(
          error: DioException(
              requestOptions: err.requestOptions, error: err.error));
    }

    switch (response.statusCode) {
      case 401:
        // UnAuthorized
        _handleUnAuthorized(err, handler);
        break;
      case 403:
      default:
        // 기타 오류
        throw APIException(error: err);
    }
  }

  void _handleUnAuthorized(
      DioException dioException, ErrorInterceptorHandler handler) {
    // 헤더에 토큰이 있는지 없는지 확인
    final header = dioException.requestOptions.headers;
    Logger().d("헤더 확인 ${header['Authorization']}");
    if (header['Authorization'] == null) {
      // 로그인 실패 or 리프레시 토큰 만료
      throw APIException(error: dioException);
    } else {
      // 토큰 만료
      _handleTokenExpiration(dioException.requestOptions, handler);
    }
  }

  void _handleTokenExpiration(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    HCApi.refreshHeader();
    final Function()? onRefreshToken = HCApi.refreshAccessToken;

    try {
      if (onRefreshToken == null) {
        throw Exception("No refresh token function available");
      }

      String? newAccessToken = await onRefreshToken();

      if (newAccessToken == null ||
          newAccessToken.isEmpty ||
          newAccessToken.length < 10) {
        throw Exception("refresh token is expired or invalid");
      }

      HCApi.setAccessToken(newAccessToken);

      // 원래 요청 재전송
      requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      var response = await HCApi.fetch(requestOptions);

      return handler.resolve(response);
    } on Exception catch (e) {
      // 토큰 갱신 실패 처리
      Logger().e("토큰 갱신 실패: ${e}");
      // throw APIException(
      //     error: DioException(
      //         requestOptions: requestOptions, error: e.toString()));
    }
  }
}
