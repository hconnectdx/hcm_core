// import 'package:flutter_test/flutter_test.dart';
// import 'package:hcm_core/hcm_core.dart';
// import 'package:hcm_core/hcm_core_platform_interface.dart';
// import 'package:hcm_core/hcm_core_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockHcmCorePlatform
//     with MockPlatformInterfaceMixin
//     implements HcmCorePlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final HcmCorePlatform initialPlatform = HcmCorePlatform.instance;
//
//   test('$MethodChannelHcmCore is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelHcmCore>());
//   });
//
//   test('getPlatformVersion', () async {
//     HcmCore hcmCorePlugin = HcmCore();
//     MockHcmCorePlatform fakePlatform = MockHcmCorePlatform();
//     HcmCorePlatform.instance = fakePlatform;
//
//     expect(await hcmCorePlugin.getPlatformVersion(), '42');
//   });
// }
