import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core/core/dio/model/response.dart';
import 'package:hcm_core/core/hive/hc_db.dart';
import 'package:logger/logger.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 로그인 요청의 경우 토큰을 헤더에 추가하지 않음
    if (!options.path.contains("/login")) {
      String? accessToken = await HCDB.getAccessToken();
      if (accessToken != null) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
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
        // 인가되지 않은 요청
        break;
      default:
        // 기타 오류
        break;
    }

    // return handler.next(apiException);
  }

  void _handleUnAuthorized(
      DioException dioException, ErrorInterceptorHandler handler) {
    // 헤더에 토큰이 있는지 없는지 확인
    final header = dioException.requestOptions.headers;
    Logger().d("헤더 확인 ${header['Authorization']}");
    if (header['Authorization'] == null) {
      // 로그인 실패
      throw APIException(error: dioException);
    } else {
      // 토큰 만료
      _handleTokenExpiration(dioException.requestOptions, handler);
    }
  }

  void _handleTokenExpiration(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    try {
      // refreshToken을 사용하여 토큰 갱신 요청
      final Function()? onRefreshToken = HCApi.refreshAccessToken;
      if (onRefreshToken == null) {
        throw Exception("No refresh token function available");
      }

      var newAccessToken = await onRefreshToken();
      HCApi.refreshHeader();
      HCApi.setAccessToken(newAccessToken);

      // 원래 요청 재전송
      var response = await HCApi.fetch(requestOptions);
      return handler.resolve(response);
    } catch (e) {
      // 토큰 갱신 실패 처리
      throw APIException(
          error: DioException(
              requestOptions: requestOptions,
              error: "토큰 갱신에 실패하였습니다. 다시 로그인해주세요"));
    }
  }
}

//
// class CustomLogInterceptor extends LogInterceptor {}

//
// case 0:
// // 성공 처리
// break;
// case 1:
// // 처리되지 않은 인가 처리
// break;
// case 2:
// // 엑세스토큰 만료 처리
// break;
// case 3:
// // 엑세스토큰이 유효하지 않음 처리
// break;
// default:
// // 기타 경우 처리
