import 'package:dh_music/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit is a widget that provides a configuration for ScreenUtil.
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      //GetMaterialApp is a widget that provides a set of bindings for GetX application.
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        getPages: AppRoutes.getPages,
      ),
    );
  }
}
