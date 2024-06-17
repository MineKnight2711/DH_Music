import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final currentIndex = 3.obs;

  final tabs = const [
    "Spotify",
    "D.sách phát",
    "Album",
    "Yêu thích",
    "Nhạc",
    "Thư mục"
  ];

  @override
  void onInit() {
    tabController = TabController(
      length: tabs.length,
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

  void changeTabIndex(int index) {
    currentIndex.value = index;
    tabController.animateTo(index);
  }
}
