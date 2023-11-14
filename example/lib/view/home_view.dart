import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/hcm_core.dart';
import 'package:hcm_core/utils/enum_health_index.dart';
import 'package:hcm_core_example/controller/my_home_controller.dart';
import 'package:hcm_core_example/repository/auth_repository.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HcmCoreUI.getBloodSugarRiskCard(context, "45"),
            HcmCoreUI.getBloodPressureRiskCard(context, "34"),
            HcmCoreUI.getStressCard(context, "50"),
            HcmCoreUI.getOrdinalCard(context, HealthIndex.BloodPressure, "50"),
            OutlinedButton(
                onPressed: () {
                  AuthRepository()
                      .login(userMobileNo: "01000000000", userPwd: "116622");
                },
                child: Text('통신테스트')),
          ],
        ),
      ),
    );
  }
}
