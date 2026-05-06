import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme/colors.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_body.dart';
import 'widgets/home_bottom_navigation.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColours.black,
      extendBody: true,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: HomeBody(),
          ),
          Positioned(
            bottom: 34,
            left: 24,
            right: 24,
            child: HomeBottomNavigation(),
          ),
        ],
      ),
    );
  }
}
