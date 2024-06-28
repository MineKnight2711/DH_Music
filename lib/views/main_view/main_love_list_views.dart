import 'package:dh_music/config/config_ex.dart';
import 'package:flutter/material.dart';

class FavoriteType {
  final String type;
  final List<String> musicPath;

  FavoriteType({required this.type, required this.musicPath});
}

final listFavortieType = [
  FavoriteType(type: "Bài hát yêu thích", musicPath: ["1", "2", "3"]),
  FavoriteType(type: "DownLoad", musicPath: ["1", "2", "3"]),
  FavoriteType(type: "Branch music", musicPath: ["1", "2", "3"]),
  FavoriteType(type: "Branch music", musicPath: ["1", "2", "3"]),
  FavoriteType(type: "Branch music", musicPath: ["1", "2", "3"]),
  FavoriteType(type: "Branch music", musicPath: ["1", "2", "3"]),
  FavoriteType(type: "Branch music", musicPath: ["1", "2", "3"]),
];

class LoveListView extends StatelessWidget {
  const LoveListView({super.key});

  @override
  Widget build(BuildContext context) {
    int itemCount = listFavortieType.length;
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
                  children: listFavortieType
                      .map((favoriteType) =>
                          FavoriteTypeWidget(songTitle: favoriteType.type))
                      .toList()),
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
                children: listFavortieType
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
  const FavoriteTypeWidget({
    super.key,
    required this.songTitle,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double width = screenSize.width * 0.4;
    double height = screenSize.height * 0.2;
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: height * 0.9,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset('assets/images/love_list.jpg').image,
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
          Text("favorite song",
              style: AppFonts.openSans(
                fontSize: AppFontSizes.size12,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
