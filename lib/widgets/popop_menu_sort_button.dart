import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config_ex.dart';

class PopUpMenuSortButton extends StatelessWidget {
  final List<String> options;
  const PopUpMenuSortButton({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final selectedOption = "Tên".obs;
    return PopupMenuButton<String>(
      elevation: 5,
      splashRadius: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      itemBuilder: (context) {
        return options
            .map(
              (option) => PopupMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: AppFonts.openSans(
                    fontSize: AppFontSizes.size12,
                  ),
                ),
              ),
            )
            .toList();
      },
      onSelected: (value) {
        selectedOption.value = value.toString();
      },
      child: Row(
        children: [
          const Icon(CupertinoIcons.sort_down),
          const SizedBox(width: 10),
          Obx(
            () => Text(
              selectedOption.value,
              style: AppFonts.openSans(
                fontSize: AppFontSizes.size12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
