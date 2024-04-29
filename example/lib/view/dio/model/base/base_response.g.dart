// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..statusCd = (json['statusCd'] as num?)?.toInt()
  ..statusMsg = json['statusMsg'] as String?
  ..retCd = (json['retCd'] as num?)?.toInt()
  ..retMsg = json['retMsg'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'statusCd': instance.statusCd,
      'statusMsg': instance.statusMsg,
      'retCd': instance.retCd,
      'retMsg': instance.retMsg,
    };
