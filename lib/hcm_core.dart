import 'package:flutter/cupertino.dart';
import 'package:hcm_core/utils/enum_health_index.dart';
import 'package:hcm_core/widget/card_blood_sugar_risk.dart';

class HcmCoreUI {
  /// 혈당 위험도 카드
  static Widget getBloodSugarRiskCard(BuildContext context, String value) {
    return CardWidget.getDottedCard(context, HealthIndex.BloodSugarRisk, value);
  }

  /// 혈압 위험도 카드
  static Widget getBloodPressureRiskCard(BuildContext context, String value) {
    return CardWidget.getDottedCard(
        context, HealthIndex.BloodPressureRisk, value);
  }

  /// 혈압 위험도 카드
  static Widget getStressCard(BuildContext context, String value) {
    return CardWidget.getStressCard(context, HealthIndex.Stress, value);
  }

  /// 일반 카드
  static Widget getOrdinalCard(
      BuildContext context, HealthIndex healthIndex, String value) {
    return CardWidget.getOrdinalCard(context, healthIndex, value);
  }
}
