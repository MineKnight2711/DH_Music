import 'package:dh_music/config/config_ex.dart';
import 'package:flutter/material.dart';

class LoveListView extends StatelessWidget {
  const LoveListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Không có yêu thích",
            style: AppFonts.openSans(
              fontSize: AppFontSizes.size20,
              color: AppColors.samsungIconGrey,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Hãy chạm vào biểu tượng trái tim bên cạnh danh sách phát, album, nghệ sĩ và thư mục yêu thích của bạn và chúng sẽ xuất hiện ở đây.",
            textAlign: TextAlign.center,
            style: AppFonts.openSans(
              fontSize: AppFontSizes.size12,
              color: AppColors.samsungIconGrey,
            ),
          ),
        ],
      ),
    );
  }
}
