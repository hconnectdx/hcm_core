import 'package:get/get.dart';

enum HealthIndex {
  HeartRate,
  OxygenSaturation,
  Temperature,
  Activity,
  BloodPressure,
  Stress,
  BloodSugarRisk,
  BloodPressureRisk,
}

extension HealthIndexExtension on HealthIndex {
  String get title {
    switch (this) {
      case HealthIndex.HeartRate:
        return 'heart_rate'.tr;
      case HealthIndex.BloodPressure:
        return 'blood_pressure'.tr;
      case HealthIndex.OxygenSaturation:
        return 'oxygen'.tr;
      case HealthIndex.Temperature:
        return 'temperature'.tr;
      case HealthIndex.Stress:
        return 'stress'.tr;
      case HealthIndex.Activity:
        return 'activity'.tr;
      case HealthIndex.BloodPressureRisk:
        return 'blood_pressure_danger'.tr;
      case HealthIndex.BloodSugarRisk:
        return 'blood_sugar_danger'.tr;
      default:
        return '';
    }
  }

  String get unit {
    switch (this) {
      case HealthIndex.HeartRate:
        return 'bpm';
      case HealthIndex.BloodPressure:
        return 'mmHg';
      case HealthIndex.OxygenSaturation:
        return '%';
      case HealthIndex.Temperature:
        return '°C';
      case HealthIndex.Stress:
        return '%';
      case HealthIndex.Activity:
        return 'kcal';
      default:
        return '';
    }
  }

  String get iconPath {
    switch (this) {
      case HealthIndex.HeartRate:
        return 'assets/img/icon_heartrate.png';
      case HealthIndex.BloodPressure:
      case HealthIndex.BloodPressureRisk:
        return 'assets/img/icon_bpm.png';
      case HealthIndex.OxygenSaturation:
        return 'assets/img/icon_oxygen.png';
      case HealthIndex.Temperature:
        return 'assets/img/icon_temperature.png';
      case HealthIndex.Stress:
        return 'assets/img/icon_stress.png';
      case HealthIndex.Activity:
        return 'assets/img/icon_activity.png';
      case HealthIndex.BloodSugarRisk:
        return 'assets/img/icon_blood_sugar.png';
      default:
        return '';
    }
  }
}
