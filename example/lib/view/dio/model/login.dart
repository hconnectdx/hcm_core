import 'package:hcm_core_example/view/dio/model/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login extends BaseResponse {
  Login();

  String? accessToken;
  String? refreshToken;
  int? expiresIn;
  String? userStatus;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
