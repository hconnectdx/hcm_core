import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/utils/colors.dart';
import 'package:lottie/lottie.dart';

class HCMDialog {
  // 싱글톤 인스턴스
  static final HCMDialog _instance = HCMDialog._();
  // 프라이빗 생성자
  HCMDialog._();
  // 공개적으로 접근 가능한 정적 메서드
  static HCMDialog get instance => _instance;

  void showMsgDialog({
    required String msg,
  }) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              _buildSingleMsgBody(msg),
              const SizedBox(height: 39),
              const Divider(height: 1, color: HCMColors.greyE3E3E3),
              Padding(
                padding: const EdgeInsets.only(top: 1.0, bottom: 3.0),
                child: _buildConfirmButton("확인", null),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Measure Dialog
  void showMeasureLottieDialog() {
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.only(
            top: 26.0, left: 22.0, right: 22.0, bottom: 57.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogTopBar(),
              const SizedBox(height: 54),
              _buildDialogTitleAndDescription(),
              const SizedBox(height: 20),
              _buildMeasureLottieImg(),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildMeasureLottieImg() {
    return Container(
      child: Lottie.asset('assets/lottie/bluetooth_scan_loading.json'),
    );
  }

  /// Measure Dialog Contents
  Widget _buildDialogTitleAndDescription() {
    return Column(
      children: [
        Text(
          "measuring".tr,
          style: TextStyle(fontSize: 20.0, color: HCMColors.black25282b),
        ),
        SizedBox(height: 21),
        Text(
          "msg_data_measuring".tr,
          style: TextStyle(
            fontSize: 14.0,
            color: HCMColors.black656565,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Top Bar
  Widget _buildDialogTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "측정",
          style: TextStyle(color: Colors.black, fontSize: 14.0),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Text(
            '취소',
            style: TextStyle(color: HCMColors.colorBlue0054a6, fontSize: 14.0),
          ),
        ),
      ],
    );
  }

  /// Button Type
  Widget _buildConfirmButton(String text, Function()? onReMeasure) {
    return TextButton(
      onPressed: () {
        Get.back();
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            onReMeasure?.call();
          },
        );
      },
      child: Text(
        text,
        style:
            const TextStyle(fontSize: 15.0, color: HCMColors.colorBlue0054a6),
      ),
    );
  }

  /// ButtonType End

  /// Body Type
  Widget _buildSingleMsgBody(String msg) {
    return Column(
      children: [
        Container(height: 24),
        Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14, height: 1.5, color: HCMColors.black25282b),
        ),
      ],
    );
  }

  /// Body Type End
}
