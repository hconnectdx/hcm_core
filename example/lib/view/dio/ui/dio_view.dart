import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core_example/view/dio/model/login.dart';
import 'package:hcm_core_example/view/dio/repository/auth_repository.dart';
import 'package:logger/logger.dart';

class DioView extends GetView {
  const DioView({super.key});

  @override
  Widget build(BuildContext context) {
    HCApi.initialize(
      baseUrl: 'https://ichms.hconnect.co.kr',
      refreshAccessToken: () async {
        HCApi.refreshHeader();
        FlutterSecureStorage storage = FlutterSecureStorage();
        String refreshToken = await storage.read(key: "refreshToken") ?? "";

        Login? response =
            await AuthRepository().refreshToken(refreshToken: refreshToken);

        if (response == null) {
          // 로그인 페이지로
          Logger().e("로그인 페이지로");
          return "Error";
        }

        String newAccessToken = response.accessToken ?? "";
        String newRefreshToken = response.refreshToken ?? "";

        await storage.write(key: "accessToken", value: newAccessToken);
        await storage.write(key: "refreshToken", value: newRefreshToken);

        return newAccessToken;
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () async {
                await AuthRepository()
                    .login(email: "test1@test.com", password: "1234");
              },
              child: const Text('로그인 테스트'),
            ),
            OutlinedButton(
              onPressed: () async {
                await AuthRepository().getMyInfo();
              },
              child: const Text('정보 얻기'),
            ),
          ],
        ),
      ),
    );
  }
}
