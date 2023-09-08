import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hcm_core/utils/enum_health_index.dart';
import 'package:hcm_core/widget/card_blood_sugar_risk.dart';

class HcmCore {
  // Future<String?> getPlatformVersion() {
  //   return HcmCorePlatform.instance.getPlatformVersion();
  // }
}

class HcmCoreBle extends FlutterBluePlus {
  static final adapterState = FlutterBluePlus.adapterState;
  static final scanResults = FlutterBluePlus.scanResults;

  static Future startScan(int timeout) {
    return FlutterBluePlus.startScan(
        timeout: Duration(seconds: timeout),
        androidUsesFineLocation: Platform.isAndroid);
  }

  static final isScanning = FlutterBluePlus.isScanning;
}

class HcmCoreUI {
  /// 혈당 위험도 카드
  static Widget getBloodSugarRiskCard(BuildContext context) {
    return CardWidget.getDottedCard(context, HealthIndex.BloodSugarRisk);
  }

  /// 혈압 위험도 카드
  static Widget getBloodPressureRiskCard(BuildContext context) {
    return CardWidget.getDottedCard(context, HealthIndex.BloodPressureRisk);
  }

  /// 혈압 위험도 카드
  static Widget getStressCard(BuildContext context) {
    return CardWidget.getStressCard(context, HealthIndex.Stress);
  }

  /// 일반 카드
  static Widget getOrdinalCard(BuildContext context, HealthIndex healthIndex) {
    return CardWidget.getOrdinalCard(context, healthIndex);
  }
}
