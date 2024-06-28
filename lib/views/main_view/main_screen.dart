import 'package:dh_music/views/main_view/main_love_list_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_screen_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../all_songs/all_songs_view.dart';
import '../file_path/file_path_view.dart';
import '../playlist/playlist_view.dart';
import 'music_player_widget/music_player_widget.dart';

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
      bottomNavigationBar: const SongPlayerWidget(),
    );
  }
}
