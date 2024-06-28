import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/popop_menu_sort_button.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopUpMenuSortButton(
            options: [
              "Thứ tự t.chỉnh",
              "Tên",
              "Ngày thêm",
              "Ngày đã phát",
            ],
          ),
        ],
      ),
    );
  }
}
