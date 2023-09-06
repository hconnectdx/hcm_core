import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hcm_core/utils/app_colors.dart';
import 'package:hcm_core/utils/enum_health_index.dart';

class CardWidget {
  /// 혈당 위험도
  static Widget getDottedCard(BuildContext context, HealthIndex healthIndex) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorGrey0e606eaa,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0E606EAA),
            offset: Offset(0.0, 8.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 184.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(23.5, 0, 23.5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildHealthInfoRow(healthIndex),
            const SizedBox(height: 16),
            buildHealthImoticonRow(healthIndex),
            const SizedBox(height: 13),
            const Divider(color: AppColors.greycecfd2, height: 0, thickness: 1),
            const SizedBox(height: 15),
            buildStressIndicator(),
            const SizedBox(height: 6),
            buildIndicatorLabels()
          ],
        ),
      ),
    );
  }

  /// 일반 PHR 카드
  static Widget getOrdinalCard(BuildContext context, HealthIndex healthIndex) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0E606EAA),
            offset: Offset(0.0, 8.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 130.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(23.5, 0, 23.5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildHealthInfoRow(healthIndex),
            const SizedBox(height: 16),
            buildHealthValueRow(healthIndex),
          ],
        ),
      ),
    );
  }

  /// 스트레스 카드
  static Widget getStressCard(BuildContext context, HealthIndex healthIndex) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0E606EAA),
            offset: Offset(0.0, 8.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 184.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(23.5, 0, 23.5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildHealthInfoRow(healthIndex),
            const SizedBox(height: 16),
            buildHealthValueRow(healthIndex),
            const SizedBox(height: 13),
            const Divider(color: AppColors.greycecfd2, height: 0, thickness: 1),
            const SizedBox(height: 15),
            buildStressIndicator(),
            const SizedBox(height: 6),
            buildIndicatorLabels()
          ],
        ),
      ),
    );
  }

  static Text buildIndicatorLabelsApplyStyle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12.0,
      ),
    );
  }

  static Row buildIndicatorLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIndicatorLabelsApplyStyle('lowness'.tr),
        buildIndicatorLabelsApplyStyle('average'.tr),
        buildIndicatorLabelsApplyStyle('height'.tr),
      ],
    );
  }

  static Row buildHealthInfoRow(HealthIndex healthIndex) {
    return Row(
      children: <Widget>[
        buildHealthIcon(healthIndex),
        const SizedBox(width: 8.0),
        buildHealthTitle(healthIndex),
      ],
    );
  }

  static Container buildHealthIcon(HealthIndex healthIndex) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: AppColors.colorGreyf2f4fb,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildImageAsset(healthIndex.iconPath),
    );
  }

  static Text buildHealthTitle(HealthIndex healthIndex) {
    return Text(
      healthIndex.title,
      style: TextStyle(fontSize: 16.0),
    );
  }

  static Row buildHealthValueRow(HealthIndex healthIndex) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              '100',
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8.0),
            Text(
              healthIndex.unit,
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ],
    );
  }

  static Row buildHealthImoticonRow(HealthIndex healthIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        buildHealthImoticon(healthIndex),
        buildHealthStatus(),
      ],
    );
  }

  static Row buildHealthImoticon(HealthIndex healthIndex) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        const SizedBox(width: 10.0),
        _buildFaceImoticon(healthIndex),
        const SizedBox(width: 4.0),
        buildHealthUnit(healthIndex),
      ],
    );
  }

  static Widget _buildFaceImoticon(HealthIndex healthIndex) {
    switch (healthIndex) {
      case HealthIndex.BloodSugarRisk:
        return _buildImageAsset('assets/img/emoticon_bad.png');
      case HealthIndex.BloodPressureRisk:
        return _buildImageAsset('assets/img/emoticon_good.png');
      default:
        return _buildImageAsset('assets/img/emoticon_good.png');
    }
  }

  static Widget _buildImageAsset(String path) {
    return Image.asset(
      path,
      package: 'hcm_core',
    );
  }

  static Text buildHealthUnit(HealthIndex healthIndex) {
    return Text(
      healthIndex.unit,
      style: TextStyle(fontSize: 14.0),
    );
  }

  static Text buildHealthStatus() {
    return Text(
      "혈당 지수가 높습니다.",
      style: TextStyle(fontSize: 14.0),
    );
  }

  static Stack buildStressIndicator() {
    return Stack(
      children: [
        buildIndicatorBg(22),
        buildIndicator(18),
      ],
    );
  }

  static Row buildIndicatorBg(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        count,
        (index) => buildCircle(AppColors.greyc8c9cc),
      ),
    );
  }

  static Row buildIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        22,
        (index) => buildCircle((index <= count)
            ? AppColors.getIndicatorColor(index)
            : Colors.transparent),
      ),
    );
  }

  static Container buildCircle(Color color) {
    return Container(
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
