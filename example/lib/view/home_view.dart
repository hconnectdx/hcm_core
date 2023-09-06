import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/hcm_core.dart';
import 'package:hcm_core/utils/enum_health_index.dart';
import 'package:hcm_core_example/controller/my_home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HcmCoreUI.getBloodSugarRiskCard(context),
          HcmCoreUI.getBloodPressureRiskCard(context),
          HcmCoreUI.getStressCard(context),
          HcmCoreUI.getOrdinalCard(context, HealthIndex.BloodPressure)
        ],
      ),
    );
  }
}
