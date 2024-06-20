import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:dh_music/config/config_ex.dart';
import 'package:dh_music/controller/main_screen_controller.dart';

class CustomAppBar extends GetView<MainScreenController> {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryWhite,
      toolbarHeight: AppSpacings.h30 * 3,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Transform.scale(
        scale: 0.9,
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          children: [
            SvgPicture.asset(
              "assets/svg/samsung.svg",
              width: AppSpacings.w30 * 3.5,
              colorFilter: const ColorFilter.mode(
                AppColors.samsungIconGrey,
                BlendMode.srcATop,
              ),
            ),
            SizedBox(width: AppSpacings.w10),
            Text(
              "Music",
              style: AppFonts.openSans(
                fontSize: AppFontSizes.size20,
                color: AppColors.samsungIconGrey,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.search),
        ),
        // SizedBox(width: AppSpacings.w15),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size(200, 40),
        child: SizedBox(
            height: 60,
            width: AppSpacings.sw(1),
            child: Swiper(
              controller: controller.swiperController,
              index: controller.currentIndex.value,
              scrollDirection: Axis.horizontal,
              itemCount: controller.tabs.length,
              scale: 1,
              viewportFraction: 0.25,
              fade: 0.7,
              loop: false,
              onIndexChanged: controller.onTabPressed,
              onTap: controller.swiperController.move,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Center(
                  child: Obx(
                    () => AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: controller.currentIndex.value == index ? 1.3 : 1.1,
                      child: Text(
                        controller.tabs[index],
                        style: AppFonts.openSans(
                          fontSize: AppFontSizes.size12,
                          color: controller.currentIndex.value == index
                              ? AppColors.primaryDark
                              : AppColors.samsungIconGrey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
            // RotatedBox(
            //   quarterTurns: -1,
            //   child:
            //    ListWheelScrollView(
            //     controller: controller.scrollController,
            //     itemExtent: 100,
            //     perspective: 0.0001,
            //     physics: const BouncingScrollPhysics(),
            //     // onSelectedItemChanged: (value) {
            //     //   print("index: is changing :new index $value");
            //     //   controller.onIndexChange(value);
            //     // },
            //     offAxisFraction: -0.5,
            //     children: controller.tabs.asMap().entries.map((entry) {
            //       final index = entry.key;
            //       final tab = entry.value;
            //       return GestureDetector(
            //         onTap: () => controller.onTabPressed(index),
            //         child: RotatedBox(
            //           quarterTurns: 1,
            //           child: Container(
            //             width: 50,
            //             alignment: Alignment.center,
            //             child: Obx(
            //               () => AnimatedScale(
            //                 duration: const Duration(milliseconds: 300),
            //                 scale: controller.currentIndex.value == index
            //                     ? 1.4
            //                     : 1,
            //                 child: Text(
            //                   tab,
            //                   style: AppFonts.openSans(
            //                       fontSize: AppFontSizes.size12,
            //                       color:
            //                           controller.currentIndex.value == index
            //                               ? AppColors.primaryDark
            //                               : AppColors.samsungIconGrey),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // )
            // TabBar(
            //   isScrollable: true,
            //   physics: const BouncingScrollPhysics(),
            //   controller: controller.tabController,
            //   dividerHeight: 0,
            //   unselectedLabelColor: Colors.white.withOpacity(0.3),
            //   onTap: (value) {
            //     controller.currentIndex.value = value;
            //   },
            //   labelPadding: EdgeInsets.symmetric(horizontal: AppSpacings.w15),
            //   tabs: controller.tabs.asMap().entries.map((entry) {
            //     final index = entry.key;
            //     final tab = entry.value;
            //     return Tab(
            //       child: Obx(
            //         () => AnimatedScale(
            //           duration: const Duration(milliseconds: 300),
            //           scale: controller.currentIndex.value == index ? 1.4 : 1,
            //           child: Text(
            //             tab,
            //             style: AppFonts.openSans(
            //                 fontSize: AppFontSizes.size12,
            //                 color: controller.currentIndex.value == index
            //                     ? AppColors.primaryDark
            //                     : AppColors.samsungIconGrey),
            //           ),
            //         ),
            //       ),
            //     );
            //   }).toList(),
            //   splashFactory: NoSplash.splashFactory,
            //   indicatorColor: Colors.transparent,
            // ),
            ),
      ),
    );
  }
}
