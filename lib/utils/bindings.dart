import 'package:dh_music/controller/file_path_controller.dart';
import 'package:get/get.dart';

import '../controller/main_screen_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => FilePathController());
  }
}
