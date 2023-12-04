import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class HCDB {
  static const String _authBox = 'authBox';
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _authId = 'authId';
  static const String _authKey = 'authKey';
  static const String _userSno = 'userSno';

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!_initialized) {
      await Hive.initFlutter();
      _initialized = true;
    }
  }

  static Future<bool> saveData(Map<String, dynamic> dataMap) async {
    final box = await _openBox();
    try {
      for (String key in dataMap.keys) {
        await box.put(key, dataMap[key]);
      }
    } catch (e) {
      // 저장 중 오류 발생 시 로그 기록
      Logger().e("Hive 저장 실패 메시지: $e");
      return false;
    }

    // 모든 데이터가 성공적으로 저장된 후 로그 기록
    Logger().d("저장 성공 $dataMap");
    return true;
  }

  static Future<dynamic> getData(String key, {dynamic defaultValue}) async {
    try {
      final box = await _openBox();
      return box.get(key, defaultValue: defaultValue);
    } catch (e) {
      // 오류 처리
      print('Error retrieving data: $e');
      return defaultValue; // 오류가 발생했을 때 기본값을 반환
    }
  }

  static Future<Box<dynamic>> _openBox() async {
    await initialize();
    return await Hive.openBox(_authBox);
  }

  static Future<void> saveTokens(
      {required String accessToken, required String refreshToken}) async {
    final box = await _openBox();
    await box.put(_accessTokenKey, accessToken);
    await box.put(_refreshTokenKey, refreshToken);
  }

  static Future<void> saveAuthAndSno(
      {String? authId, String, authKey, String? userSno}) async {
    final box = await _openBox();
    if (authId != null) await box.put(_authId, authId);
    if (authKey != null) await box.put(_authKey, authKey);
    if (userSno != null) await box.put(_userSno, userSno);
  }

  static Future<String?> getAccessToken() async {
    final box = await _openBox();
    return box.get(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final box = await _openBox();
    return box.get(_refreshTokenKey);
  }

  static Future<String?> getAuthId() async {
    final box = await _openBox();
    return box.get(_authId);
  }

  static Future<String?> getAuthKey() async {
    final box = await _openBox();
    return box.get(_authKey);
  }

  static Future<String?> getUserSno() async {
    final box = await _openBox();
    return box.get(_userSno);
  }
}
