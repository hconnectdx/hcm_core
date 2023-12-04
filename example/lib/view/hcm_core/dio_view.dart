import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core_example/comm/dio/auth_repository.dart';
import 'package:hcm_core_example/getx_controller/dio_controller.dart';

class DioView extends GetView<DioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                AuthRepository()
                    .login(userMobileNo: "01000000000", userPwd: "116622");
              },
              child: Text('로그인 테스트'),
            ),
            OutlinedButton(
              onPressed: () {
                AuthRepository()
                    .login(userMobileNo: "01000000000", userPwd: "116622");
              },
              child: Text('로그인 테스트'),
            ),
          ],
        ),
      ),
    );
  }
}
