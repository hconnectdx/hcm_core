import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/core/hive/hc_db.dart';

class HiveView extends GetView {
  const HiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () async {
                await HCDB.saveData(
                  {
                    'aa': 1,
                    'ss': 2,
                  },
                );
              },
              child: const Text('값 저장하기 테스트'),
            ),
            OutlinedButton(
              onPressed: () async {
                var aa = await HCDB.getData('aa');
                print(aa);
              },
              child: const Text('값 불러오기'),
            )
          ],
        ),
      ),
    );
  }
}
