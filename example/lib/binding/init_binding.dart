import 'package:get/get.dart';
import 'package:hcm_core_example/controller/my_home_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
