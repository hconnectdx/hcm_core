import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/core/ble/view/ble_scan_view.dart';
import 'package:hcm_core_example/controller/my_home_controller.dart';
import 'package:hcm_core_example/view/dio/ui/dio_view.dart';
import 'package:hcm_core_example/view/hive/hive_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () {
              Get.to(BleScanView(
                (device) {
                  print("$device lk;ihp");
                },
              ));
            },
            child: const Text('블루투스 샘플 확인'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.to(const DioView());
            },
            child: const Text('dio 샘플 확인'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.to(const HiveView());
            },
            child: const Text('Hive 샘플 확인'),
          ),
        ],
      ),
    );
  }
}
