import 'package:flutter/cupertino.dart';
import 'package:hcm_core/utils/enum_health_index.dart';
import 'package:hcm_core/widget/card_blood_sugar_risk.dart';

class HcmCore {
  // Future<String?> getPlatformVersion() {
  //   return HcmCorePlatform.instance.getPlatformVersion();
  // }
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
