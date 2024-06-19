import 'package:dh_music/views/main_love_list_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/main_screen_controller.dart';
import '../widgets/custom_app_bar.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(200, 150),
        child: CustomAppBar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: TabBarView(
          controller: controller.tabController,
          children: const [
            Center(child: Text("Spotify")),
            Center(child: LoveListView()),
            Center(child: Text("Danh sách phát")),
            Center(child: Text("Bài hát")),
            Center(child: Text("Album")),
            Center(child: Text("Nghệ sĩ")),
            Center(child: Text("Thư mục")),
          ],
        ),
      ),
    );
  }
}
