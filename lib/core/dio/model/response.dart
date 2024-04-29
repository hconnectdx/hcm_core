import 'package:dio/dio.dart';

class APIException extends DioException {
  APIException({
    required DioException error,
  }) : super(
          requestOptions: error.requestOptions,
          response: error.response,
          type: error.type,
          error: error.error,
        );
}
