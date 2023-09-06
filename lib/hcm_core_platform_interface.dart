import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hcm_core_method_channel.dart';

abstract class HcmCorePlatform extends PlatformInterface {
  /// Constructs a HcmCorePlatform.
  HcmCorePlatform() : super(token: _token);

  static final Object _token = Object();

  static HcmCorePlatform _instance = MethodChannelHcmCore();

  /// The default instance of [HcmCorePlatform] to use.
  ///
  /// Defaults to [MethodChannelHcmCore].
  static HcmCorePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HcmCorePlatform] when
  /// they register themselves.
  static set instance(HcmCorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
