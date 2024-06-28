import 'package:dh_music/config/config_ex.dart';
import 'package:flutter/material.dart';

class FavoriteType {
  final String type;
  final List<String> musicPath;
  final String imagePath;

  FavoriteType(
      {required this.type, required this.musicPath, required this.imagePath});
}

final listFavoriteType = [
  FavoriteType(
      type: "Bài hát yêu thích",
      musicPath: ["1", "2", "3"],
      imagePath: "assets/images/Banner1.jpg"),
  FavoriteType(
      type: "DownLoad",
      musicPath: ["1", "2", "3"],
      imagePath: 'assets/images/banner2.jpg'),
  FavoriteType(
      type: "Branch music",
      musicPath: ["1", "2", "3"],
      imagePath: 'assets/images/Banner1.jpg'),
  FavoriteType(
      type: "Branch 2 music",
      musicPath: ["1", "2", "3"],
      imagePath: 'assets/images/love_list.jpg'),
  FavoriteType(
      type: "Branch 3 music",
      musicPath: ["1", "2", "3"],
      imagePath: 'assets/images/love_list.jpg'),
  FavoriteType(
      type: "Branch 4 music",
      musicPath: ["1", "2", "3"],
      imagePath: 'assets/images/love_list.jpg'),
  FavoriteType(
      type: "Branch 5 music",
      musicPath: ["1", "2", "3"],
      imagePath: 'assets/images/love_list.jpg'),
];

class LoveListView extends StatelessWidget {
  const LoveListView({super.key});

  @override
  Widget build(BuildContext context) {
    int itemCount = listFavoriteType.length;
    int rows = (itemCount / 2).ceil();
    double gridHeight = rows * AppSpacings.ch(165) + (rows - 1) * 10;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: gridHeight,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 30.0,
                children: listFavoriteType
                    .map((favoriteType) => FavoriteTypeWidget(
                        songTitle: favoriteType.type,
                        imagePath: favoriteType.imagePath))
                    .toList(),
              ),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: listFavoriteType
                    .map((song) => const TopMusicWidget())
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopMusicWidget extends StatelessWidget {
  const TopMusicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/images/Banner1.jpg').image,
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.samsungIconGrey,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          Text(
            "songTitle",
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

class FavoriteTypeWidget extends StatelessWidget {
  final String songTitle;
  final String imagePath;
  const FavoriteTypeWidget(
      {super.key, required this.songTitle, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double width = AppSpacings.cw(145);
    double height = AppSpacings.ch(130);
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                opacity: 0.5,
              ),
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.samsungIconGrey.withOpacity(0.7),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                Text(
                  songTitle,
                  style: AppFonts.openSans(
                    fontSize: AppFontSizes.size16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "favorite song",
            style: AppFonts.openSans(
              fontSize: AppFontSizes.size12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
