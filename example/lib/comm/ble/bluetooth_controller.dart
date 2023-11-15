import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  static final BluetoothController _instance = BluetoothController._internal();
  factory BluetoothController() => _instance;
  BluetoothController._internal();

  static String serviceUUID =
      "6E400001-B5A3-F393-E0A9-E50E24DCCA9E".toLowerCase();
  static String characteristicWriteUUID =
      "6E400002-B5A3-F393-E0A9-E50E24DCCA9E".toLowerCase();
  static String charactericticNotifyUUID =
      "6E400003-B5A3-F393-E0A9-E50E24DCCA9E".toLowerCase();

  // Bluetooth 디바이스 목록
  var devices = <BluetoothDevice>[].obs;

  // 연결 중인 디바이스
  var connectedDevice = Rx<BluetoothDevice?>(null);

  // Bluetooth 상태
  var isScanning = false.obs;
  Rx<BluetoothAdapterState> bluetoothState = BluetoothAdapterState.unknown.obs;
  var deviceConnectionState = Rx<BluetoothConnectionState?>(null);

  @override
  void onInit() {
    super.onInit();
    FlutterBluePlus.adapterState.listen((state) {
      bluetoothState.value = state;
    });
  }

  // 스캔 시작
  startScan() async {
    // 스캔 중이면 작동하지 않음
    isScanning.value = true;
    devices.clear();
    // 스캔한 디바이스 목록 업데이트
    print('스캔시작');
    FlutterBluePlus.scanResults.listen((results) {
      print(results);
      for (ScanResult r in results) {
        print('Scanned Item: ${r.device.localName}');
        if (r.device.localName.isNotEmpty && !devices.contains(r.device)) {
          devices.add(r.device);
        }
      }
    });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    FlutterBluePlus.isScanning.listen((isCurrentlyScanning) {
      isScanning.value = isCurrentlyScanning;
    });
  }

  // 스캔 중지
  stopScan() {
    FlutterBluePlus.stopScan();
    isScanning.value = false;
  }

  connectToDevice(BluetoothDevice device) async {
    deviceConnectionState.value = BluetoothConnectionState.connecting;
    try {
      await device.connect(autoConnect: true);
      if (Platform.isAndroid) await device.pair();

      //deviceConnectionState.value = BluetoothConnectionState.connected;

      // 연결 상태 감지
      device.connectionState.listen((newState) async {
        switch (newState) {
          case BluetoothConnectionState.connecting:
          case BluetoothConnectionState.connected:
            connectedDevice.value = device;
            deviceConnectionState.value = BluetoothConnectionState.connected;
            await setNotify(true);
            if (await requestIsBonded()) {
              if (Get.currentRoute == '/DiscoveryView') {
                Get.back();
              }
            }
          case BluetoothConnectionState.disconnected:
            deviceConnectionState.value = BluetoothConnectionState.disconnected;
            disconnectDevice();
            break;
          default:
            break;
        }
      });
    } catch (e) {
      deviceConnectionState.value = BluetoothConnectionState.disconnected;
    }
  }

  Future<bool> requestIsBonded() async {
    try {
      List<BluetoothService>? services =
          await connectedDevice.value?.discoverServices();

      BluetoothService? targetService = services
          ?.firstWhere((service) => service.uuid.toString() == serviceUUID);

      BluetoothCharacteristic? notifyCharacteristic = targetService
          ?.characteristics
          .firstWhere((c) => c.uuid.toString() == charactericticNotifyUUID);

      BluetoothCharacteristic? writeCharacteristic = targetService
          ?.characteristics
          .firstWhere((c) => c.uuid.toString() == characteristicWriteUUID);

      String response = await writeAndReadResponse(
          notifyCharacteristic!, writeCharacteristic!, "STATE_REQUEST");

      return response.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  requestData(String requestMsg) async {
    try {
      List<BluetoothService>? services =
          await connectedDevice.value?.discoverServices();

      BluetoothService? targetService = services
          ?.firstWhere((service) => service.uuid.toString() == serviceUUID);
      BluetoothCharacteristic? notifyCharacteristic = targetService
          ?.characteristics
          .firstWhere((c) => c.uuid.toString() == charactericticNotifyUUID);
      BluetoothCharacteristic? writeCharacteristic = targetService
          ?.characteristics
          .firstWhere((c) => c.uuid.toString() == characteristicWriteUUID);

      // String response = await writeAndReadResponse(
      //     notifyCharacteristic, writeCharacteristic, "STATE_REQUEST");

      //if (response == "STATE_S:0") {
      String res = await writeAndReadResponse(
          notifyCharacteristic, writeCharacteristic, requestMsg);
      return res;
      //  } else {}
    } catch (e) {}
  }

  setNotify(bool state) async {
    try {
      List<BluetoothService>? services =
          await connectedDevice.value?.discoverServices();

      services?.forEach((service) async {
        if (service.uuid.toString() ==
            BluetoothController.serviceUUID.toLowerCase()) {
          var characteristics = service.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            if (c.uuid.toString() == charactericticNotifyUUID.toLowerCase()) {
              c.setNotifyValue(state);
            }
          }
        }
      });
    } catch (e) {}
  }

  Future<String> writeAndReadResponse(BluetoothCharacteristic? c,
      BluetoothCharacteristic? cw, String requestMsg) async {
    String response;
    await Future.delayed(const Duration(seconds: 2));
    var completer = Completer();
    bool isFirstEvent = true;

    // 타임아웃 처리를 위한 스트림 변환
    Stream<List<int>>? timedStream =
        c?.lastValueStream.timeout(Duration(seconds: 30), onTimeout: (sink) {
      sink.addError(TimeoutException('No event received for 30 seconds'));
    });
    // 스트림 구독 시작
    StreamSubscription<List<int>>? subscription = timedStream?.listen((bytes) {
      // 첫 번째 이벤트는 처리하지 않습니다.
      if (isFirstEvent) {
        isFirstEvent = false;
        return;
      }

      // 바이트 배열을 문자열로 변환합니다.
      String response = utf8.decode(bytes);
      completer.complete(response);
    }, onError: (error) {
      if (error is TimeoutException) {
      } else {}
    });

    await Future.delayed(const Duration(seconds: 1));
    print(cw);
    await cw?.write(utf8.encode(requestMsg));
    response = await completer.future;
    try {
      await Future.delayed(const Duration(seconds: 1));
      subscription?.cancel();
      subscription = null;
    } catch (e) {}
    await Future.delayed(const Duration(seconds: 1));
    return response;
  }

  Future<String> writeAndReadResponse2(BluetoothCharacteristic c,
      BluetoothCharacteristic cw, String requestMsg) async {
    String response;

    await Future.delayed(const Duration(seconds: 1));
    var completer = Completer();
    bool isFirstEvent = true;

    // Listen for the response
    var subscription = c.lastValueStream.listen((bytes) {
      if (isFirstEvent) {
        isFirstEvent = false;
        return;
      }
      String response = utf8.decode(bytes).toString();
      completer.complete(response);
    });

    await Future.delayed(const Duration(seconds: 1));
    await cw.write(utf8.encode(requestMsg));

    response = await completer.future;
    try {
      await Future.delayed(const Duration(seconds: 1));
      subscription.cancel();
    } catch (e) {}
    await Future.delayed(const Duration(seconds: 1));

    return response;
  }

  disconnectDevice() async {
    if (connectedDevice.value != null) {
      deviceConnectionState.value = BluetoothConnectionState.disconnecting;
      await connectedDevice.value!.disconnect();
      connectedDevice.value = null;
      deviceConnectionState.value = BluetoothConnectionState.disconnected;
    }
  }

  @override
  void onClose() {
    stopScan();

    disconnectDevice();
    super.onClose();
  }
}
