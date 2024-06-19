import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  late SwiperController swiperController;
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
    swiperController = SwiperController();

    addTabControllerListener();
    super.onInit();
  }

  void addTabControllerListener() {
    tabController.addListener(() {
      currentIndex.value = tabController.index;
      swiperController.move(tabController.index);
    });
  }

  void onTabPressed(int index) {
    currentIndex.value = index;
    tabController.index = index;
    tabController.animateTo(index);
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
