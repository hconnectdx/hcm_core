// auth_repository.dart

import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core_example/view/dio/api/account_api.dart';
import 'package:hcm_core_example/view/dio/model/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hcm_core_example/view/dio/repository/base_repository.dart';

class AuthRepository extends BaseRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  Future<Login?> login(
      {required String email, required String password}) async {
    Login? response = await requestAPI(() async {
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
    });
    return response;
  }

  Future<Login?> refreshToken({required String refreshToken}) async {
    Login? response = await requestAPI(
      () async {
        final response = await AccountApi(HCApi.dio).refreshToken({
          'refreshToken': refreshToken,
        });

        final storage = FlutterSecureStorage();
        await storage.write(
            key: "accessToken", value: response.accessToken ?? "");
        await storage.write(
            key: "refreshToken", value: response.refreshToken ?? "");

        return response;
      },
    );
    return response;
  }

  Future<String?> getMyInfo() async {
    return await requestAPI(() async {
      final response = await AccountApi(HCApi.dio).getMyInfo();
      return response.data?.toJson().toString();
    });
  }
}
