import 'package:dio/dio.dart' as HCDio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core/core/hive/hc_db.dart';
import 'package:hcm_core_example/view/dio/ui/dio_view.dart';
import 'package:hcm_core_example/view/home_view.dart';
import 'package:logger/logger.dart';

void main() {
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
