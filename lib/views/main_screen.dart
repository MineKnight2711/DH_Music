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
