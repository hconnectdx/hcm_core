import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/core/dio/hc_dio.dart';
import 'package:hcm_core_example/binding/init_binding.dart';
import 'package:hcm_core_example/view/hcm_core/ble_view.dart';
import 'package:hcm_core_example/view/hcm_core/dio_view.dart';
import 'package:hcm_core_example/view/home_view.dart';

void main() {
  HCDio.initialize(baseUrl: 'https://mapi-stg.health-on.co.kr');
  runApp(HcmCoreApp());
}

class HcmCoreApp extends StatelessWidget {
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
        GetPage(name: '/home', page: () => HomeView(), binding: InitBinding()),
        GetPage(
            name: '/dio_view', page: () => DioView(), binding: InitBinding()),
        GetPage(
            name: '/ble_view', page: () => BleView(), binding: InitBinding()),
      ],
    );
  }
}
