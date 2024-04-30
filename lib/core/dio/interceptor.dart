import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core/core/dio/model/response.dart';
import 'package:logger/logger.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('login')) HCApi.refreshHeader();
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;

    if (response == null) {
      throw APIException(error: err);
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
    final token = header['Authorization'];

    if (isTokenAvailable(token) == false) {
      // 로그인 실패 or 리프레시 토큰 만료
      throw APIException(error: dioException);
    } else {
      // 토큰 만료
      _handleTokenExpiration(dioException.requestOptions, handler);
    }
  }

  void _handleTokenExpiration(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    HCApi.refreshHeader(); // 토큰만료 헤더 초기화
    final Function()? onRefreshToken = HCApi.refreshAccessToken;

    if (onRefreshToken == null) {
      // HCApi initialize에서 refreshAccessToken이 설정되지 않았을 경우
      throw Exception("No refresh token function available");
    }

    String? newAccessToken;

    try {
      newAccessToken = await onRefreshToken();
      if (isTokenAvailable(newAccessToken) == false) {
        throw Exception("Refresh token failed");
      }
    } catch (e) {
      Logger().e(e.toString());
      return;
    }

    HCApi.setAccessToken(newAccessToken ?? "");

    // 원래 요청 재전송
    requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    var response = await HCApi.fetch(requestOptions);

    return handler.resolve(response);
  }

  bool isTokenAvailable(String? token) {
    bool isAvailable = true;
    if (token == null || token.isEmpty || token.length < 10) {
      isAvailable = false;
    }
    return isAvailable;
  }
}
