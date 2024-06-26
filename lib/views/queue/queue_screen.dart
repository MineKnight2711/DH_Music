import 'package:dh_music/views/queue/components/player_indicator_buttons.dart';
import 'package:dh_music/widgets/popop_menu_sort_button.dart';
import '../../config/config_ex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/file_path_controller.dart';
import 'components/progress_bar_widget.dart';
import 'components/queue_music_list_widget.dart';

class QueueScreen extends GetView<FilePathController> {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   toolbarHeight: AppSpacings.ch(65),
      //   leading: IconButton(
      //     onPressed: () => Get.back(),
      //     icon: const Icon(CupertinoIcons.chevron_down),
      //   ),
      //   actions: [],
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacings.h10,
          horizontal: AppSpacings.w10,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFE0E0FF), // Light purple-blue
              Color(0xFFB0B0FF), // Slightly darker purple-blue
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: AppSpacings.ch(40)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(CupertinoIcons.chevron_down),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.add),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.pencil),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PopUpMenuSortButton(
                  initialSelectedOption: "Thứ tự t.chỉnh",
                  options: ["Thứ tự t.chỉnh", "Ngày thêm", "Tên", "Nghệ sĩ"],
                ),
                Text("1/1")
              ],
            ),
            const QueueMusicListWidget(),
            const ProgressBarWidget(),
            const PlayerIndicatorButtonsWidget(),
          ],
        ),
      ),
    );
  }
}
