import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/theme/colors.dart';
import '../../home/controllers/home_controller.dart';

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final selectedColor = AppColours.noteGreen.obs;
  final selectedIcon = Icons.backpack.obs;

  final List<Color> availableColors = [
    AppColours.noteGreen,
    AppColours.noteYellow,
    AppColours.notePink,
    AppColours.notePurple,
    const Color(0xFFFFC0CB),
    const Color(0xFFFFA07A),
  ];

  final List<IconData> availableIcons = [
    Icons.backpack,
    Icons.phone_android,
    Icons.tablet_mac,
    Icons.palette,
    Icons.straighten,
    Icons.accessibility_new,
    Icons.code,
    Icons.menu_book,
  ];

  void createTask() {
    if (titleController.text.isEmpty) {
      Get.snackbar("Error", "Title cannot be empty", 
        backgroundColor: Colors.redAccent.withValues(alpha: 0.5),
        colorText: Colors.white,
      );
      return;
    }

    final homeController = Get.find<HomeController>();
    final newId = (homeController.tasks.length + 1).toString();
    
    final newTask = TaskModel(
      id: newId,
      task: titleController.text,
      time: timeController.text.isEmpty ? "No time set" : timeController.text,
      color: selectedColor.value,
      icon: selectedIcon.value,
      initialPosition: const Offset(100, 100),
      rotation: (Random().nextDouble() - 0.5) * 0.1,
    );

    homeController.tasks.add(newTask);
    homeController.taskOrder.add(newId);
    
    Get.back();
  }
}
