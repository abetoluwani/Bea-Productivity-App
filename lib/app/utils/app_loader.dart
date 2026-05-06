import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/widget.dart';
 
class AppLoader {
  static void show({String? message}) {
    if (Get.isDialogOpen == true) {
      Get.back();   
    }
    Get.dialog(
      AppLoadingScreen(message: message),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.3),  
      useSafeArea: false,
    );
  }

  static void hide() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
