import 'package:hcm_core_example/view/dio/model/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_info.g.dart';

@JsonSerializable()
class MyInfo extends BaseResponse {
  MyInfo();

  Data? data;

  factory MyInfo.fromJson(Map<String, dynamic> json) => _$MyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MyInfoToJson(this);
}

@JsonSerializable()
class Data {
  Data();

  String? imgUrl;
  String? nickNm;
  int? lvl;
  String? userNm;
  String? phoneNo;
  String? birth;
  String? gender;
  String? nationality;
  String? loginType;
  String? email;
  String? admdngNm;
  String? height;
  String? bodyType;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
