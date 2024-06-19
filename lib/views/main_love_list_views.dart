import 'package:dh_music/config/config_ex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoveListView extends StatelessWidget {
  const LoveListView({super.key});

  final listSong = const [
    "Bài hát yêu thích",
    "Dowload",
    "Brand music",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: listSong
                    .map((song) => SongWidget(songTitle: song))
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class SongWidget extends StatelessWidget {
  final String songTitle;
  const SongWidget({
    super.key,
    required this.songTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // const Icon(Icons.music_note, size: 30.0),
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
    );
  }
}

// class CounterWidget extends StatefulWidget {
//   const CounterWidget({super.key});

//   @override
//   State<CounterWidget> createState() => _CounterWidgetState();
// }

// class _CounterWidgetState extends State<CounterWidget> {
//   int count = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Center(
//           child: Text(
//             count.toString(),
//             style: const TextStyle(
//               fontSize: 24,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: FloatingActionButton(
//             onPressed: () {
//               setState(() {
//                 count++;
//               });
//             },
//             child: const Icon(CupertinoIcons.add),
//           ),
//         ),
//       ],
//     );
//   }
// }

// RxInt count = 0.obs;
// Rx<int> count = Rx<int>(0);

// class CounterWidget extends StatelessWidget {
//   CounterWidget({super.key});
//   final RxInt count = 0.obs;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Center(
//           child: Obx(
//             () => Text(
//               count.toString(),
//               style: const TextStyle(
//                 fontSize: 24,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: FloatingActionButton(
//             onPressed: () {
//               count.value++;
//             },
//             child: const Icon(CupertinoIcons.add),
//           ),
//         ),
//       ],
//     );
//   }
// }
