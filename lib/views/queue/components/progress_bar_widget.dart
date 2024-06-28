import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/config_ex.dart';
import '../../../controller/file_path_controller.dart';

class ProgressBarWidget extends GetView<FilePathController> {
  const ProgressBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Obx(
        () => ProgressBar(
          progressBarColor: Colors.white,
          bufferedBarColor: Colors.white,
          baseBarColor: AppColors.progressBarWhite,
          thumbColor: Colors.white,
          thumbGlowRadius: 15,
          thumbRadius: 7,
          progress: controller.currentDuration.value,
          // buffered: Duration(milliseconds: 2000),
          thumbCanPaintOutsideBar: true,

          total: Duration(
              milliseconds: controller.currentSong.value?.trackDuration ?? 0),
          onSeek: (duration) {
            controller.seekDuration(duration);
          },
        ),
      ),
    );
  }
}
