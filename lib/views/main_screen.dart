import 'package:card_swiper/card_swiper.dart';
import 'package:dh_music/config/config_ex.dart';
import 'package:dh_music/controller/main_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main_love_list_views.dart';
import '../widgets/custom_app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:
          PreferredSize(preferredSize: Size(200, 80), child: CustomAppBar()),
      body: Center(
        child: LoveListView(),
      ),
    );
  }
}
