import 'package:flutter_screenutil/flutter_screenutil.dart';

///Caculate the pixel width and height using package flutter_screenutil
class AppSpacings {
  static final h5 = 5.h;
  static final h10 = 10.h;
  static final h15 = 15.h;
  static final h20 = 20.h;
  static final h25 = 25.h;
  static final h30 = 30.h;

  static final w5 = 5.w;
  static final w10 = 10.w;
  static final w15 = 15.w;
  static final w20 = 20.w;
  static final w25 = 25.w;
  static final w30 = 30.w;

  /// Caclulate the vertical height space of the screen
  static double ch(double spaceSize) {
    return spaceSize.h;
  }

  /// Caclulate the horizontal width space of the screen
  static double cw(double spaceSize) {
    return spaceSize.w;
  }

  /// Caclulate the height of the screen
  static double sh(double screenHeight) {
    return screenHeight.sh;
  }

  /// Caclulate the width of the screen
  static double sw(double screenWidth) {
    return screenWidth.sw;
  }
}
