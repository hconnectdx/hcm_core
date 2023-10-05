import 'dart:ui';

import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'msg_fail_measurement':
              'Measurement failed with motion detection or semi-accurate information\n.\nMeasure again.',
          'msg_ble_off':
              'Your smartphone\'s Bluetooth is turned off.\nPlease turn on Bluetooth to check the value.',
          'msg_no_connection':
              'The band and app are not linked.\nLink the band.',
          'msg_activated_state':
              'The band is measuring the biosignal.\nAfter the measurement is completed on the band,\n it can be measured in the app.',
          'msg_data_measuring':
              "Data is being measured.\nMeasurement will take about 30 seconds.",
          'measuring': "measuring",
          // Dialog Msg
          'response_ok': 'SUCCESS',

          // HomeView
          'measurement_guide_msg':
              'Press the start measurement button\nto measure your health.',
          'start_measurement': 'start_measurement',
          'last_measurement_time':
              'Last measurement time: Last Measurement Time : %{month} \${day}, \${year}, \${hour}:\${min} \${noon}',

          // Discovery View
          'bluetooth_connect': 'Connect Bluetooth',
          'bluetooth_connect_device': 'Bluetooth Devices',
          'bluetooth_connected_device': 'Connected Device',
          'pin_code_information': 'Pin number can be checked on the band',
          'pin_code_information_sub':
              'How to enter PIN number screen: Band home screen > Settings > Bluetooth',

          // HomeCardWidget
          'low_intensity_exercise': 'low intensity exercise %min min',

          // StressCardWidget
          'lowness': 'low',
          'average': 'aver',
          'height': 'high',
          'stress_guide': 'he stress level is %level',

          // enum_health_index
          'heart_rate': 'Heart rate',
          'blood_pressure': 'Blood pressure',
          'oxygen': 'Oxygen',
          'temperature': 'Temperature',
          'stress': 'Stress',
          'activity': 'Activity',
          'blood_sugar_danger': 'Blood Sugar Risk',
          'blood_pressure_danger': 'Blood Pressure Risk',
        },
        'ko_KR': {
          'msg_fail_measurement': '움직임 감지 또는 부정확한 정보로\n측정에 실패했습니다.\n재측정하세요.',
          'msg_ble_off': '스마트폰의 블루투스가 꺼져있습니다.\n측정값을 확인하려면 블루투스를 켜주세요.',
          'msg_no_connection': '밴드와 앱이 연동되어 있지 않습니다.\n밴드를 연동하세요.',
          'msg_activated_state':
              '밴드에서 생체 신호를 측정 중입니다.\n밴드에서 측정 완료 후,\n 앱에서 측정 가능합니다.',
          'msg_data_measuring': "데이터 측정중입니다.\n측정 시간은 30초 가량 소요됩니다.",
          'measuring': "측정 중",

          // Dialog Msg
          'response_ok': '성공',

          // HomeView
          'measurement_guide_msg': '측정 시작 버튼을 눌러\n건강을 측정하세요.',
          'start_measurement': '측정시작',
          'last_measurement_time':
              '마지막 측정 시간 : %year년 %month월 %day일, %noon %hour:%min',

          // DiscoveryView
          'bluetooth_connect': '블루투스 연동',
          'bluetooth_connect_device': '블루투스 연동 디바이스',
          'bluetooth_connected_device': '연결된 디바이스',
          'pin_code_information': '핀 번호는 밴드에서 확인 가능합니다',
          'pin_code_information_sub': '핀번호 화면 진입 방법 : 밴드 홈화면 > 설정 > 블루투스',

          // HomeCardWidget
          'low_intensity_exercise': '저강도 운동 %min분',

          // StressCardWidget
          'lowness': '낮음',
          'average': '평균',
          'height': '높음',
          'stress_guide': '스트레스 지수가 %level 편입니다.',

          // enum_health_index
          'heart_rate': '심박수',
          'blood_pressure': '혈압',
          'oxygen': '산소포화도',
          'temperature': '체온',
          'stress': '스트레스',
          'activity': '활동량',
          'blood_sugar_danger': '혈당 위험도',
          'blood_pressure_danger': '혈압 위험도',
        }
      };

  static String trWithParams(String key, Map<String, String> params) {
    String template = key.tr;
    for (var entry in params.entries) {
      template = template.replaceAll('%${entry.key}', entry.value);
    }
    return template;
  }

  static String getMonthName(int month, Locale locale) {
    if (locale.languageCode == 'ko') {
      return '$month';
    } else if (locale.languageCode == 'en') {
      List<String> monthNames = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return monthNames[month - 1];
    }
    // 기본값으로 숫자를 반환하거나 다른 언어를 추가할 수 있습니다.
    return '$month';
  }
}
