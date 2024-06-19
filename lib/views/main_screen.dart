import 'package:dh_music/config/config_ex.dart';
import 'package:dh_music/views/main_love_list_views.dart';
import 'package:flutter/cupertino.dart';
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
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: TabBarView(
          controller: controller.tabController,
          children: [
            Center(child: Text("Spotify")),
            // CounterWidget(),
            Center(child: LoveListView()),
            PlaylistView(),
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

class PlaylistView extends StatelessWidget {
  const PlaylistView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text(
                  "Thứ tự t.chỉnh",
                  style: AppFonts.openSans(
                    fontSize: AppFontSizes.size12,
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  "Tên",
                  style: AppFonts.openSans(
                    fontSize: AppFontSizes.size12,
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  "Ngày thêm",
                  style: AppFonts.openSans(
                    fontSize: AppFontSizes.size12,
                  ),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  "Ngày đã phát",
                  style: AppFonts.openSans(
                    fontSize: AppFontSizes.size12,
                  ),
                ),
              ),
            ];
          },
          // icon: const Icon(CupertinoIcons.sort_down),
          splashRadius: 0,

          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(CupertinoIcons.sort_down),
                Text("Sắp xếp theo: Thứ tự tùy chỉnh"),
              ],
            ),
          ),
        )
      ],
    );
  }
}
