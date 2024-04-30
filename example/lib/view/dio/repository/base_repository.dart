import 'package:hcm_core/core/dio/model/response.dart';
import 'package:logger/logger.dart';

class BaseRepository<T> {
  Future<T?> requestAPI(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on APIException catch (e) {
      Logger().e("APIException: ${e}");
      rethrow;
    } on Exception catch (e) {
      Logger().e("Exception: ${e}");
      rethrow;
    }
  }
}
