import 'package:flutter/material.dart';
import 'package:hcm_core/core/ble/view/ble_scan_view.dart';

class BleView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BleScanView((device) {}),
    );
  }
}
