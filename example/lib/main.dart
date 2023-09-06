import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/utils/app_colors.dart';
import 'package:hcm_core/utils/translation.dart';
import 'package:hcm_core_example/binding/init_binding.dart';
import 'package:hcm_core_example/view/home_view.dart';

void main() {
  runApp(HcmCoreApp());
}

class HcmCoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'SpoqaHanSansNeo',
          scaffoldBackgroundColor: AppColors.backgroundColor),
      darkTheme: ThemeData(fontFamily: 'SpoqaHanSansNeo'),
      initialRoute: '/home',
      translations: AppTranslation(),
      locale: Get.deviceLocale,
      getPages: [
        GetPage(name: '/home', page: () => HomeView(), binding: InitBinding()),
      ],
    );
  }
}
