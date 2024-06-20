import 'package:dh_music/utils/bindings.dart';
import 'package:dh_music/views/main_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/home';

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () => const MainScreen(),
      transition: Transition.noTransition,
      binding: AppBindings(),
    ),
  ];
}
