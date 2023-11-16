class Utils {
  static bool isNumeric(String str) {
    // 정수 또는 부동 소수점 패턴
    final pattern = r'^-?\d+(\.\d+)?$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }
}