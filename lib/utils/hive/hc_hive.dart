import 'package:hive_flutter/hive_flutter.dart';

class HCHive {
  static const String _authBox = 'authBox';
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _authId = 'authId';
  static const String _authKey = 'authKey';
  static const String _userSno = 'userSno';

  static bool _initialized = false;

  static Future<void> _initialize() async {
    if (!_initialized) {
      await Hive.initFlutter();
      _initialized = true;
    }
  }

  static Future<Box<dynamic>> _openBox() async {
    await _initialize();
    return await Hive.openBox(_authBox);
  }

  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
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
