import 'package:flutter/material.dart';
import 'package:hcm_core_example/view/dio/repository/auth_repository.dart';

class DioView extends StatefulWidget {
  DioView({Key? key}) : super(key: key);

  @override
  _DioViewState createState() => _DioViewState();
}

class _DioViewState extends State<DioView> {
  var text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () async {
                try {
                  await AuthRepository()
                      .login(email: "test1@test.com", password: "1234");
                } catch (e) {
                  print("Exception: ${e}");
                  print("로그인에 실패했어요~");
                }
              },
              child: const Text('로그인 테스트'),
            ),
            OutlinedButton(
              onPressed: () async {
                try {
                  text = await AuthRepository().getMyInfo() ?? "";
                  setState(() {});
                } catch (e) {
                  print("Exception: ${e}");
                  print("정보얻기 실패했어요~");
                }
              },
              child: const Text('정보 얻기'),
            ),
            Text("return: ${text}"),
          ],
        ),
      ),
    );
  }
}


// class DioView extends GetView {
//   DioView({super.key});
//   var text = "";

//   @override
//   Widget build(BuildContext context) {
//     HCApi.initialize(
//       baseUrl: 'https://ichms.hconnect.co.kr',
//       refreshAccessToken: () async {
//         HCApi.refreshHeader();
//         FlutterSecureStorage storage = FlutterSecureStorage();
//         String refreshToken = await storage.read(key: "refreshToken") ?? "";

//         try {
//           Login? response =
//               await AuthRepository().refreshToken(refreshToken: refreshToken);

//           if (response == null || response.retCd == 3) {
//             Logger().e("로그인 페이지로");
//             return null;
//           }

//           String newAccessToken = response.accessToken ?? "";
//           String newRefreshToken = response.refreshToken ?? "";

//           await storage.write(key: "accessToken", value: newAccessToken);
//           await storage.write(key: "refreshToken", value: newRefreshToken);

//           return newAccessToken;
//         } catch (e) {
//           Logger().e("Exception: ${e}");
//           // 로그아웃
//           return null;
//         }
//       },
//     );

//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             OutlinedButton(
//               onPressed: () async {
//                 await AuthRepository()
//                     .login(email: "test1@test.com", password: "1234");
//               },
//               child: const Text('로그인 테스트'),
//             ),
//             OutlinedButton(
//               onPressed: () async {
//                 await AuthRepository().getMyInfo();
//               },
//               child: const Text('정보 얻기'),
//             ),
//             Text(text),
//           ],
//         ),
//       ),
//     );
//   }
// }
