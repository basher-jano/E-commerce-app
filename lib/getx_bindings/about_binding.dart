import 'package:get/get.dart';
import 'package:my_application/modules/about/about.controller.dart';

class AboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AboutController>(AboutController());
  }
}
