import 'dart:io';

import 'package:dh_music/widgets/popop_menu_sort_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/config_ex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/file_path_controller.dart';

class QueueScreen extends GetView<FilePathController> {
  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSpacings.ch(65),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(CupertinoIcons.chevron_down),
        ),
        actions: [
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
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacings.h10,
          horizontal: AppSpacings.w10,
        ),
        child: Column(
          children: [
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
            Column(
              children: controller.musicQueue.map(
                (song) {
                  return FutureBuilder(
                    future: MetadataRetriever.fromFile(File(song)),
                    builder: (context, snapshot) {
                      final metadata = snapshot.data!;
                      if (snapshot.hasData) {
                        return ListTile(
                          leading: metadata.albumArt != null
                              ? Image.memory(metadata.albumArt!)
                              : SvgPicture.asset(
                                  "assets/svg/samsung_music.svg"),
                          title: Text(
                            metadata.trackName ?? song.split("/").last,
                            style: AppFonts.openSans(
                              fontSize: AppFontSizes.size14,
                            ),
                          ),
                          subtitle: Text(
                            metadata.authorName ?? song.split("/").last,
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                },
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
}
