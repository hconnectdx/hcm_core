import 'package:get/get.dart';
import 'package:hcm_core_example/controller/my_home_controller.dart';
import 'package:hcm_core_example/getx_controller/dio_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(DioController());
  }
}
