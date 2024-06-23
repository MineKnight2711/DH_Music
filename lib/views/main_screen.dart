import 'package:dh_music/config/fonts.dart';
import 'package:dh_music/views/main_love_list_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_marquee/text_marquee.dart';
import '../controller/main_screen_controller.dart';
import '../widgets/custom_app_bar.dart';
import 'all_songs/all_songs_view.dart';
import 'file_path/file_path_view.dart';
import 'playlist/playlist_view.dart';

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
            const Center(child: Text("Spotify")),
            // CounterWidget(),
            const Center(child: LoveListView()),
            const PlaylistView(),
            AllSongsViews(),
            const Center(child: Text("Album")),
            const Center(child: Text("Nghệ sĩ")),
            const FilePathView(),
          ],
        ),
      ),
      bottomNavigationBar: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: const Color(0xfffe8508),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    Image.asset("assets/images/love_list.jpg").image,
              ),
              Container(
                width: 120,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMarquee(
                      "Day la mot ban nhac co ten rat dai",
                      curve: Curves.easeInOut,
                      rtl: true,
                      duration: const Duration(milliseconds: 10000),
                      style: AppFonts.openSans(
                        fontSize: AppFontSizes.customSize(13),
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Nghe si sang tac",
                      style: AppFonts.openSans(
                        fontSize: AppFontSizes.size12,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    // padding: EdgeInsets.symmetric(horizontal: 5),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous_sharp,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.skip_next_sharp, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.queue_music, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
