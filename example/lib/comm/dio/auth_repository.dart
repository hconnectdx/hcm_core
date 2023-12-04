// auth_repository.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hcm_core/core/dio/hc_api.dart';
import 'package:hcm_core/core/hive/hc_db.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  Future<void> login({
    required String userMobileNo,
    required String userPwd,
  }) async {
    try {
      await _loginStep1(userMobileNo, userPwd);
      await _loginStep2();
    } catch (e) {
      print('Login Error: $e');
      rethrow;
    }
  }

  Future<void> _loginStep1(String userMobileNo, String userPwd) async {
    final response = await HCApi.post(
      '/IF-HLO-CHMC-0300',
      data: {
        'userCountryNo': '82',
        'userMobileNo': userMobileNo,
        'userPwd': userPwd,
        'osType': Platform.isAndroid ? '90103200' : '90103100',
        'registrationId': HCApi.temp_token,
        'languageCode': '10801300',
        'appVersion': '1.2.7',
        'reqDate': "20231108171931",
      },
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.data;
      final tokensData = responseData['data'];
      await HCDB.saveTokens(
        accessToken: tokensData['accessToken'],
        refreshToken: tokensData['refreshToken'],
      );
      await HCDB.saveAuthAndSno(
        authId: tokensData['authId'],
        authKey: tokensData['authKey'],
        //authKey: tokensData['userSno'],
      );
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<void> _loginStep2() async {
    final response = await HCApi.post('/IF-HLO-CHMC-0500', data: {
      'authKey': await HCDB.getAuthKey(),
      'pageNum': 0,
      'reqDate': "20231108171931",
    });

    if (response.statusCode == 200) {
      final responseData = response.data;
      final tokensData = responseData['data'];
      await HCDB.saveAuthAndSno(
        userSno: tokensData['userSno'],
      );
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }
}
