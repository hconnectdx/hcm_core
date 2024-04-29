import 'package:dio/dio.dart';
import 'package:hcm_core_example/view/dio/model/login.dart';
import 'package:hcm_core_example/view/dio/model/my_info.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

part 'account_api.g.dart';

@RestApi()
abstract class AccountApi {
  factory AccountApi(Dio dio) = _AccountApi;

  @POST('/auth/login')
  Future<Login> reqeustLogin(@Body() Map<String, dynamic> body);

  @POST('/auth/refresh')
  Future<Login> refreshToken(@Body() Map<String, dynamic> body);

  @GET('/api/app/getMyInfo.do')
  Future<MyInfo> getMyInfo();
}
