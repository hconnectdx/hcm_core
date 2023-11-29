import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core_example/controller/my_home_controller.dart';
import 'package:hcm_core_example/view/hcm_core/ble_view.dart';
import 'package:hcm_core_example/view/hcm_core/dio_view.dart';
import 'package:hcm_core_example/view/hcm_core/hive_view.dart';
import 'package:hcm_core_example/view/hcm_gui/component_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // HcmCoreUI.getBloodSugarRiskCard(context, "45"),
          // HcmCoreUI.getBloodPressureRiskCard(context, "34"),
          // HcmCoreUI.getStressCard(context, "50"),
          // HcmCoreUI.getOrdinalCard(context, HealthIndex.BloodPressure, "50"),
          OutlinedButton(
            onPressed: () {
              Get.to(BleView());
            },
            child: Text('블루투스 샘플 확인'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.to(DioView());
            },
            child: Text('dio 샘플 확인'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.to(ComponentView());
            },
            child: Text('Component샘플 확인'),
          ),
          OutlinedButton(
            onPressed: () {
              Get.to(HiveView());
            },
            child: Text('Hive 샘플 확인'),
          ),
        ],
      ),
    );
  }
}
