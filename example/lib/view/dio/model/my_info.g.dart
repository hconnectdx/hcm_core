// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyInfo _$MyInfoFromJson(Map<String, dynamic> json) => MyInfo()
  ..statusCd = (json['statusCd'] as num?)?.toInt()
  ..statusMsg = json['statusMsg'] as String?
  ..retCd = (json['retCd'] as num?)?.toInt()
  ..retMsg = json['retMsg'] as String?
  ..data = json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$MyInfoToJson(MyInfo instance) => <String, dynamic>{
      'statusCd': instance.statusCd,
      'statusMsg': instance.statusMsg,
      'retCd': instance.retCd,
      'retMsg': instance.retMsg,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data()
  ..imgUrl = json['imgUrl'] as String?
  ..nickNm = json['nickNm'] as String?
  ..lvl = (json['lvl'] as num?)?.toInt()
  ..userNm = json['userNm'] as String?
  ..phoneNo = json['phoneNo'] as String?
  ..birth = json['birth'] as String?
  ..gender = json['gender'] as String?
  ..nationality = json['nationality'] as String?
  ..loginType = json['loginType'] as String?
  ..email = json['email'] as String?
  ..admdngNm = json['admdngNm'] as String?
  ..height = json['height'] as String?
  ..bodyType = json['bodyType'] as String?;

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'nickNm': instance.nickNm,
      'lvl': instance.lvl,
      'userNm': instance.userNm,
      'phoneNo': instance.phoneNo,
      'birth': instance.birth,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'loginType': instance.loginType,
      'email': instance.email,
      'admdngNm': instance.admdngNm,
      'height': instance.height,
      'bodyType': instance.bodyType,
    };
