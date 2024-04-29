// auth_repository.dart

import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core/core/dio/model/response.dart';
import 'package:hcm_core_example/view/dio/api/account_api.dart';
import 'package:hcm_core_example/view/dio/model/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hcm_core_example/view/dio/model/my_info.dart';
import 'package:logger/logger.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  Future<Login?> login(
      {required String email, required String password}) async {
    try {
      final response = await AccountApi(HCApi.dio).reqeustLogin({
        'email': email,
        'password': password,
      });

      final storage = FlutterSecureStorage();
      final accessToken = response.accessToken ?? "";
      final refreshToken = response.refreshToken ?? "";
      await storage.write(key: "accessToken", value: accessToken);
      await storage.write(key: "refreshToken", value: refreshToken);

      print("access Token: ${accessToken}");
      print("refresh Token: ${refreshToken}");

      HCApi.setAccessToken(accessToken);

      return response;
    } on APIException catch (e) {
      Logger().e("APIException: ${e}");
    } on Exception catch (e) {
      Logger().e("Exception: ${e}");
    }

    return null;
  }

  Future<Login?> refreshToken({required String refreshToken}) async {
    try {
      final response = await AccountApi(HCApi.dio).refreshToken({
        'refreshToken': refreshToken,
      });

      final storage = FlutterSecureStorage();
      await storage.write(
          key: "accessToken", value: response.accessToken ?? "");
      await storage.write(
          key: "refreshToken", value: response.refreshToken ?? "");

      return response;
    } on APIException catch (e) {
      Logger().e("APIException: ${e}");
    } on Exception catch (e) {
      Logger().e("Exception: ${e}");
    }

    return null;
  }

  Future<MyInfo?> getMyInfo() async {
    try {
      final response = await AccountApi(HCApi.dio).getMyInfo();
      return response;
    } on APIException catch (e) {
      Logger().e("APIException: ${e}");
    } on Exception catch (e) {
      Logger().e("Exception: ${e}");
    }
    return null;
  }
}
