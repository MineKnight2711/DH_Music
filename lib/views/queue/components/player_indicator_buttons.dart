import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/config_ex.dart';
import '../../../controller/file_path_controller.dart';

class PlayerIndicatorButtonsWidget extends GetView<FilePathController> {
  const PlayerIndicatorButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            controller.isShuffle.value = !controller.isShuffle.value;
            controller.shuffle();
          },
          icon: Obx(
            () => SvgPicture.asset(
              controller.isShuffle.value
                  ? "assets/svg/shuffle.svg"
                  : "assets/svg/shuffle_off.svg",
            ),
          ),
        ),
        IconButton(
          onPressed: () => controller.playPrevious(),
          icon: SvgPicture.asset(
            "assets/svg/previous_song.svg",
            width: AppSpacings.w25,
          ),
        ),
        IconButton(
          onPressed: () => controller.playOrPause(),
          icon: Obx(
            () => SvgPicture.asset(
              controller.currentPlayerState.value == PlayerState.playing
                  ? "assets/svg/pause_song.svg"
                  : "assets/svg/play_song.svg",
              width: AppSpacings.w25,
            ),
          ),
        ),
        IconButton(
          onPressed: () => controller.playNext(),
          icon: SvgPicture.asset(
            "assets/svg/next_song.svg",
            width: AppSpacings.w25,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/svg/play_all.svg",
            width: AppSpacings.w25,
          ),
        ),
      ],
    );
  }
}
