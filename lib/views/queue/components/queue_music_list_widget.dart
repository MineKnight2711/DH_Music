import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../config/config_ex.dart';
import '../../../controller/file_path_controller.dart';

class QueueMusicListWidget extends GetView<FilePathController> {
  const QueueMusicListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.musicQueue.isEmpty) {
          return const Center(
            child: Text("Không có bài hát nào trong hàng đợi :(("),
          );
        } else {
          if (controller.shuffledQueue.isEmpty) {
            return ListMusicQueueBuilder(listQueue: controller.musicQueue);
          } else {
            return ListMusicQueueBuilder(listQueue: controller.shuffledQueue);
          }
        }
      },
    );
  }
}

class ListMusicQueueBuilder extends GetView<FilePathController> {
  final List<Metadata> listQueue;
  const ListMusicQueueBuilder({super.key, required this.listQueue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacings.sh(0.6),
      child: ListView(
        children: listQueue.map(
          (songMetadata) {
            return InkWell(
              onTap: () => controller.startMusic(songMetadata.filePath ?? ""),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width: AppSpacings.cdg(40),
                        height: AppSpacings.cdg(40),
                        child: songMetadata.albumArt != null
                            ? Image.memory(
                                songMetadata.albumArt!,
                                fit: BoxFit.cover,
                              )
                            : SvgPicture.asset(
                                "assets/svg/samsung_music.svg",
                                width: 20,
                                colorFilter: const ColorFilter.mode(
                                  Colors.transparent,
                                  BlendMode.srcATop,
                                ),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: AppSpacings.sw(0.7),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songMetadata.trackName ??
                                  "${songMetadata.filePath?.split("/").last}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.openSans(
                                fontSize: AppFontSizes.size14,
                                color: songMetadata.filePath ==
                                        controller.currentSong.value?.filePath
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              songMetadata.authorName ?? "Không có",
                              style: AppFonts.openSans(
                                fontSize: AppFontSizes.size12,
                                color: songMetadata.filePath ==
                                        controller.currentSong.value?.filePath
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(Icons.more_vert)
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
