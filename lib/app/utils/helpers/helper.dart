import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiss_army_component/swiss_army_component.dart';
import '../utils.dart';

class AppHelpers {
  static Color? getColor(String value) {
    switch (value) {
      case "primary":
        return AppColours.primary;
      case "secondary":
        return AppColours.secondary;
      case "black":
        return AppColours.black;
      case "white":
        return AppColours.white;
      case "green":
        return Colors.green;
      case "red":
        return AppColours.red;
      case "orange":
        return Colors.orange;
      case "grey":
        return AppColours.grey;
      case "lime":
        return Colors.limeAccent;
      case "blue":
        return Colors.blue;
    }
    return null;
  }

  static void showAlert(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: BigAppText(title),
        content: BigAppText(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: BigAppText("OK"),
          ),
        ],
      ),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

  static Size screenSize() {
    return Get.size;
  }

  static double screenWidth() {
    return Get.width;
  }

  static double screenHeight() {
    return Get.height;
  }
}
