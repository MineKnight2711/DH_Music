import 'package:dh_music/config/config_ex.dart';
import 'package:dh_music/config/spacings.dart';
import 'package:dh_music/controller/file_path_controller.dart';
import 'package:dh_music/widgets/popop_menu_sort_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FilePathView extends GetView<FilePathController> {
  const FilePathView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppSpacings.h10, left: AppSpacings.w15, right: AppSpacings.w15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PopUpMenuSortButton(
            options: [
              "Tên",
              "Ngày thêm",
            ],
          ),
          SizedBox(height: AppSpacings.h15),
          Obx(
            () {
              if (controller.directoryToFileNames.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final path = controller.directoryToFileNames[index];
                    print(path.filePaths);
                    return Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SvgPicture.asset(
                                "assets/svg/samsung_music.svg",
                                width: 60,
                              ),
                            ),
                            const Positioned(
                              bottom: 3,
                              right: 3,
                              child: Icon(
                                Icons.folder_outlined,
                                size: 15,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppSpacings.w10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                path.directoryPath.split("/").last,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                path.directoryPath.replaceFirst(
                                    "/storage/emulated/0", "/Bộ nhớ trong"),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: AppSpacings.w30 * 2.3,
                  ),
                  itemCount: controller.directoryToFileNames.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
