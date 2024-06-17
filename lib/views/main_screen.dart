import 'package:dh_music/config/config_ex.dart';
import 'package:dh_music/controller/main_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            height: 40,
            width: AppSpacings.sw(1) - AppSpacings.w10,
            child: TabBar(
              isScrollable: true,
              controller: controller.tabController,
              dividerHeight: 0,
              onTap: (value) {
                controller.currentIndex.value = value;
              },
              tabs: controller.tabs.asMap().entries.map((entry) {
                final index = entry.key;
                final tab = entry.value;
                return Tab(
                  child: Obx(
                    () => AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: controller.currentIndex.value == index ? 1.4 : 1,
                      child: Text(
                        tab,
                        style: AppFonts.openSans(
                            fontSize: AppFontSizes.size12,
                            color: controller.currentIndex.value == index
                                ? AppColors.primaryDark
                                : AppColors.samsungIconGrey.withOpacity(0.5)),
                      ),
                    ),
                  ),
                );
              }).toList(),
              splashFactory: NoSplash.splashFactory,
              indicatorColor: Colors.transparent,
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}
