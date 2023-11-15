import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core_example/controller/my_home_controller.dart';
import 'package:hcm_core_example/view/ble_view.dart';

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
                Get.toNamed('/ble_view');
              },
              child: Text('블루투스 샘플 확인')),
          OutlinedButton(
              onPressed: () {
                Get.to(BleView());
              },
              child: Text('dio 샘플 확인')),
          // OutlinedButton(
          //     onPressed: () {
          //       AuthRepository()
          //           .login(userMobileNo: "01000000000", userPwd: "116622");
          //     },
          //     child: Text('통신테스트')),
        ],
      ),
    );
  }
}
