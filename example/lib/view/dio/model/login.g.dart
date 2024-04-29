// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login()
  ..statusCd = (json['statusCd'] as num?)?.toInt()
  ..statusMsg = json['statusMsg'] as String?
  ..retCd = (json['retCd'] as num?)?.toInt()
  ..retMsg = json['retMsg'] as String?
  ..accessToken = json['accessToken'] as String?
  ..refreshToken = json['refreshToken'] as String?
  ..expiresIn = (json['expiresIn'] as num?)?.toInt()
  ..userStatus = json['userStatus'] as String?;

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'statusCd': instance.statusCd,
      'statusMsg': instance.statusMsg,
      'retCd': instance.retCd,
      'retMsg': instance.retMsg,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'userStatus': instance.userStatus,
    };
