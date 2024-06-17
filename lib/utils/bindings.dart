import 'package:get/get.dart';

import '../controller/main_screen_controller.dart';

class MainScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}
