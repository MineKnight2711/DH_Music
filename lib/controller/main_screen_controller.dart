import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final currentIndex = 3.obs;

  @override
  void onInit() {
    tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: currentIndex.value,
    );
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  final tabs = const [
    "Spotify",
    "D.sách phát",
    "Album",
    "Yêu thích",
    "Nhạc",
    "Thư mục"
  ];
}
