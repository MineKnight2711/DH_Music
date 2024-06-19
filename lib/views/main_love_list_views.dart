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
            "Danh sách yêu thích",
            style: AppFonts.openSans(
              fontSize: AppFontSizes.size20,
              color: AppColors.samsungIconGrey,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: List.generate(3, (index) => _buildSongTile(index)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongTile(int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/images/love_list.jpg').image,
          opacity: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          Text(
            "Bài hát yêu thích",
            style: AppFonts.openSans(
              fontSize: AppFontSizes.size16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
