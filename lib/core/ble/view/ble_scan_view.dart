import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:hcm_core/core/ble/view/bluetooth_controller.dart';

class BleScanView extends GetView<BluetoothController> {
  Function(BluetoothDevice) onConnect;
  @override
  // TODO: implement controller
  BluetoothController get controller => Get.put(BluetoothController(onConnect));

  BleScanView(this.onConnect);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: _buildAppBar(),
      body: _buildDiscoveryBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xff707070)),
      elevation: 0.5,
      centerTitle: true,
      backgroundColor: const Color(0xfff7f7f7),
      title: _buildAppBarTitle(),
      actions: _buildAppBarActions(),
      leading: _buildLeadingIcon(),
    );
  }

  IconButton _buildLeadingIcon() {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back),
    );
  }

  Text _buildAppBarTitle() {
    return Text(
      '블루투스 연동',
      style: TextStyle(
        color: const Color(0xff707070),
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      Obx(() => (controller.isScanning.value == true)
          ? _buildLoadingLottieImg()
          : _buildScanImg())
    ];
  }

  Widget _buildLoadingLottieImg() {
    return IconButton(
      icon: Icon(Icons.access_alarms_sharp),
      onPressed: () {},
    );
  }

  Widget _buildScanImg() {
    return IconButton(
        onPressed: () {
          controller.startScan();
        },
        icon: const Icon(Icons.replay));
  }

  Widget _buildDiscoveryBody() {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConnectInfoWidget(),
          // const SizedBox(height: 31),
          // Text(
          //   'bluetooth_connect_device'.tr,
          //   style: TextStyle(color: AppColors.black0a0a0a, fontSize: 14.0),
          // ),
          _buildConnectedTile(),
          const SizedBox(height: 31),
          Text(
            '블루투스 연동 디바이스',
            style: TextStyle(color: Color(0xff0a0a0a), fontSize: 14.0),
          ),
          const SizedBox(height: 12),
          Flexible(child: _buildDiscoveryList()),
        ],
      ),
    );
  }

  Widget _buildConnectedTile() {
    BluetoothDevice? connectedDevice = controller.connectedDevice.value;
    if (connectedDevice != null) {
      return _buildConnectedTileItem(connectedDevice);
    } else {
      return const SizedBox.shrink();
    }
  }

  Container _buildDiscoveryList() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Obx(
        () => ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.devices.length,
          itemBuilder: (ctx, index) => _buildTileItem(controller.devices[index],
              index == controller.devices.length - 1),
        ),
      ),
    );
  }

  Widget _buildConnectedTileItem(BluetoothDevice device) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 30),
        Text(
          '연결된 디바이스',
          style: TextStyle(color: Colors.black, fontSize: 14.0),
        ),
        Obx(
          () => Card(
            margin: const EdgeInsets.only(top: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            elevation: 0,
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(left: 26.0, right: 16.0),
                  title: _buildTileText(device),
                  subtitle: (controller.connectedDevice.value == device)
                      ? _buildSubTileText()
                      : null,
                  // 여기에 필요한 경우 추가로 subtitle, leading, trailing 등의 항목을 넣을 수 있습니다.
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildTileText(BluetoothDevice device) {
    TextStyle textStyle;
    String deviceName = device.localName;

    switch (controller.deviceConnectionState.value) {
      case BluetoothConnectionState.connecting:
      case BluetoothConnectionState.connected:
        textStyle = _buildActivatedStyle();
        break;
      default:
        textStyle = _buildNoConnectionStyle();
        break;
    }
    if (controller.connectedDevice.value != device) {
      textStyle = _buildNoConnectionStyle();
    }

    return Text(deviceName, style: textStyle);
  }

  Widget? _buildSubTileText() {
    TextStyle textStyle;
    String txtState = "";

    switch (controller.deviceConnectionState.value) {
      case BluetoothConnectionState.connected:
        textStyle = _buildNormalStyle();
        txtState = "연결 됨";
        break;
      case BluetoothConnectionState.connecting:
        textStyle = _buildNormalStyle();
        txtState = "연결 중 …  ";
        break;
      default:
        textStyle = _buildNoConnectionStyle();
        break;
    }

    if (txtState == "") return null;

    return Text(txtState, style: textStyle);
  }

  Widget _buildTileItem(BluetoothDevice device, bool isLastItem) {
    return InkWell(
      onTap: () async {
        controller.connectedDevice.value = device;
        controller.connectToDevice(device);
      },
      child: Obx(
        () => Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 26.0, right: 16.0),
              title: _buildTileText(device),
              subtitle: (controller.connectedDevice.value == device)
                  ? _buildConnectingSubText()
                  : null,
              // 여기에 필요한 경우 추가로 subtitle, leading, trailing 등의 항목을 넣을 수 있습니다.
            ),
            if (!isLastItem) const Divider(thickness: 0, height: 0.1),
          ],
        ),
      ),
    );
  }

  Widget? _buildConnectingSubText() {
    switch (controller.deviceConnectionState.value) {
      case BluetoothConnectionState.connected:
        return Text("연결 됨",
            style: _buildNormalStyle(), textAlign: TextAlign.left);
      case BluetoothConnectionState.disconnected:
        return null;
      default:
        return Text("연결 중 …  ",
            style: _buildNormalStyle(), textAlign: TextAlign.left);
    }
  }

  TextStyle _buildNormalStyle() {
    return const TextStyle(
        color: Color(0xffadadad),
        fontWeight: FontWeight.w400,
        fontFamily: "SpoqaHanSansNeo",
        fontStyle: FontStyle.normal,
        fontSize: 12.0);
  }

  TextStyle _buildNoConnectionStyle() {
    return const TextStyle(
      color: Color(0xff707070),
      fontStyle: FontStyle.normal,
      fontSize: 15.0,
      letterSpacing: -0.2,
    );
  }

  TextStyle _buildActivatedStyle() {
    return const TextStyle(
      color: Color(0x460060af),
      fontStyle: FontStyle.normal,
      fontSize: 15.0,
      letterSpacing: -0.2,
    );
  }

  Widget _buildConnectInfoWidget() {
    return Container(
      height: 67,
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Color(0x140056ac),
          borderRadius: BorderRadius.all(Radius.circular(14.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 18),
            child: Row(
              children: [
                const Icon(Icons.info, color: Color(0xff0060af)),
                Container(width: 3),
                Text("핀 번호는 밴드에서 확인 가능합니다",
                    style: const TextStyle(
                      color: Color(0xff0060af),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text("핀번호 화면 진입 방법 : 밴드 홈화면 > 설정 > 블루투스",
                style: const TextStyle(
                  fontSize: 12,
                )),
          )
        ],
      ),
    );
  }
}
