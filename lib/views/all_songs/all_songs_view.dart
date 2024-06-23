import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:dh_music/controller/file_path_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../config/config_ex.dart';
import '../../utils/custom_bean.dart';
import '../../widgets/popop_menu_sort_button.dart';

class AllSongsViews extends GetView<FilePathController> {
  final ItemScrollController itemScrollController = ItemScrollController();
  AllSongsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.only(
            top: AppSpacings.h10,
            left: AppSpacings.w15,
            right: AppSpacings.w15,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const PopUpMenuSortButton(
                    options: [
                      "Tên",
                      "Ngày Thêm",
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xffe9e9eb),
                      ),
                      iconSize: 15,
                      icon: const Icon(CupertinoIcons.shuffle),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: AppSpacings.w10),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xffe9e9eb),
                      ),
                      iconSize: 15,
                      icon: const Icon(CupertinoIcons.play_arrow_solid),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacings.h10),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.allMusic.length,
                  separatorBuilder: (context, index) => Divider(
                    indent: AppSpacings.w30 * 2.3,
                  ),
                  itemBuilder: (context, index) {
                    final song = controller.allMusic[index];

                    return FutureBuilder(
                      future: MetadataRetriever.fromFile(File(song)),
                      builder: (context, snapshot) {
                        final metadata = snapshot.data;
                        if (snapshot.hasData) {
                          return Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: metadata?.albumArt != null
                                    ? Image.memory(
                                        metadata!.albumArt!,
                                        width: 60,
                                      )
                                    : SvgPicture.asset(
                                        "assets/svg/samsung_music.svg",
                                        width: 60,
                                      ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: AppSpacings.w10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: AppSpacings.sw(0.6),
                                          child: Text(
                                            metadata?.trackName ?? song,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        metadata?.trackArtistNames != null
                                            ? Row(
                                                children: metadata!
                                                    .trackArtistNames!
                                                    .map(
                                                      (e) => Text(
                                                        e,
                                                        style:
                                                            AppFonts.openSans(
                                                          fontSize: AppFontSizes
                                                              .size14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              )
                                            : Text(
                                                "Không có",
                                                style: AppFonts.openSans(
                                                  fontSize: AppFontSizes.size14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 20,
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert),
                                  )
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            snapshot.error.toString(),
                            style: AppFonts.openSans(
                              fontSize: AppFontSizes.size16,
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 5,
          top: 50,
          child: Container(
            width: 25,
            height: AppSpacings.ch(500),
            decoration: BoxDecoration(
              color: const Color(0xffe9e9eb),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AzListView(
              data: controller.allMusic
                  .map((item) => MyBean(name: item))
                  .toList(),
              itemCount: controller.allMusic.length,
              indexBarItemHeight: AppSpacings.h15 * 1.2,
              itemScrollController: itemScrollController,
              indexHintBuilder: (context, tag) {
                return Padding(
                  padding: const EdgeInsets.only(left: 110),
                  child: CircleAvatar(
                    // width: 100,
                    // height: 100,
                    radius: 40,
                    backgroundColor: Colors.blue.withOpacity(0.5),
                    child: Text(
                      tag,
                      style: AppFonts.openSans(
                        fontSize: AppFontSizes.customSize(30),
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                );
              },
              itemBuilder: (context, index) {
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }
}
