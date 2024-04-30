import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core/core/dio/model/response.dart';
import 'package:hcm_core_example/view/dio/model/login.dart';
import 'package:hcm_core_example/view/dio/repository/auth_repository.dart';
import 'package:hcm_core_example/view/dio/ui/dio_view.dart';
import 'package:hcm_core_example/view/home_view.dart';
import 'package:logger/logger.dart';

void main() {
  HCApi.initialize(
    baseUrl: 'https://ichms.hconnect.co.kr',
    refreshAccessToken: () async {
      HCApi.refreshHeader();
      FlutterSecureStorage storage = FlutterSecureStorage();
      String refreshToken = await storage.read(key: "refreshToken") ?? "";

      try {
        Login? response =
            await AuthRepository().refreshToken(refreshToken: refreshToken);

        if (response == null || response.retCd == 3) {
          Logger().e("로그인 페이지로");
          return null;
        }

        String newAccessToken = response.accessToken ?? "";
        String newRefreshToken = response.refreshToken ?? "";

        await storage.write(key: "accessToken", value: newAccessToken);
        await storage.write(key: "refreshToken", value: newRefreshToken);

        return newAccessToken;
      } on APIException catch (e) {
        Logger().e("Exception: ${e}");
        // 로그아웃
        return null;
      } on Exception catch (e) {
        Logger().e("Exception: ${e}");
        // 로그아웃
        return null;
      }
    },
  );
  runApp(const HcmCoreApp());
}

class HcmCoreApp extends StatelessWidget {
  const HcmCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo', scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(fontFamily: 'SpoqaHanSansNeo'),
      initialRoute: '/home',
      locale: Get.deviceLocale,
      getPages: [
        GetPage(name: '/home', page: () => HomeView()),
        GetPage(name: '/dio_view', page: () => DioView())
      ],
    );
  }
}
