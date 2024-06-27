import 'package:audioplayers/audioplayers.dart';
import 'package:dh_music/config/config_ex.dart';
import 'package:dh_music/config/routes.dart';
import 'package:dh_music/controller/file_path_controller.dart';
import 'package:dh_music/views/main_view/main_love_list_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:text_marquee/text_marquee.dart';
import '../../controller/main_screen_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../all_songs/all_songs_view.dart';
import '../file_path/file_path_view.dart';
import '../playlist/playlist_view.dart';

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

class SongPlayerWidget extends GetView<FilePathController> {
  const SongPlayerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacings.ch(43),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: const Color(0xfffe8508),
        onPressed: () {},
        child: Container(
          width: AppSpacings.sw(1),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppSpacings.sw(0.12),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      Image.asset("assets/images/love_list.jpg").image,
                ),
              ),
              SizedBox(
                width: AppSpacings.sw(0.35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMarquee(
                      "Day la mot ban nhac co ten rat dai",
                      curve: Curves.easeInOut,
                      rtl: true,
                      duration: const Duration(milliseconds: 10000),
                      style: AppFonts.openSans(
                        fontSize: AppFontSizes.size14,
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
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        "assets/svg/previous_song.svg",
                        width: AppSpacings.w20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: controller.currentSong.value != null
                          ? () {
                              controller.playOrPause();
                            }
                          : () {},
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          controller.currentPlayerState.value ==
                                      PlayerState.playing &&
                                  controller.currentPlayerState.value !=
                                      PlayerState.stopped
                              ? "assets/svg/pause_song.svg"
                              : "assets/svg/play_song.svg",
                          width: AppSpacings.w25,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        "assets/svg/next_song.svg",
                        width: AppSpacings.w20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => AppRoutes.navigateTo(route: AppRoutes.queue),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        "assets/svg/music_list.svg",
                        width: AppSpacings.w20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
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
