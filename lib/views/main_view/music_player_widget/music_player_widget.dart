import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:text_marquee/text_marquee.dart';

import '../../../config/config_ex.dart';
import '../../../controller/file_path_controller.dart';

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
                child: Obx(
                  () => CircleAvatar(
                    radius: 20,
                    backgroundImage: controller.currentSong.value != null &&
                            controller.currentSong.value?.albumArt != null
                        ? Image.memory(
                            controller.currentSong.value!.albumArt!,
                            fit: BoxFit.cover,
                          ).image
                        : Image.asset("assets/images/love_list.jpg").image,
                  ),
                ),
              ),
              SizedBox(
                width: AppSpacings.sw(0.35),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextMarquee(
                        controller.currentSong.value != null
                            ? "${controller.currentSong.value?.trackName ?? controller.currentSong.value?.filePath?.split("/").last}"
                            : "Không có bài hát nào trong hàng chờ",
                        curve: Curves.easeInOut,
                        rtl: true,
                        duration: const Duration(milliseconds: 10000),
                        style: AppFonts.openSans(
                          fontSize: AppFontSizes.size14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        controller.currentSong.value != null
                            ? controller.currentSong.value?.authorName ??
                                "Không biết"
                            : "",
                        style: AppFonts.openSans(
                          fontSize: AppFontSizes.size12,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
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
