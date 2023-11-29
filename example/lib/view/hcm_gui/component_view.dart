import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/component/card/ui_card.dart';
import 'package:hcm_core/utils/enum_health_index.dart';

class ComponentView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HCComponentCard.getStressCard(context, HealthIndex.HeartRate, "10"),
            // HCComponentGraphBar.getBar()
          ],
        ),
      ),
    );
  }
}
