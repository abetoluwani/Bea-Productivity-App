import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/theme/colors.dart';

class TaskModel {
  final String id;
  final String task;
  final String time;
  final Color color;
  final IconData icon;
  final Rx<Offset> position;
  final double rotation;
  final String? emoji;

  TaskModel({
    required this.id,
    required this.task,
    required this.time,
    required this.color,
    required this.icon,
    required Offset initialPosition,
    this.rotation = 0.0,
    this.emoji,
  }) : position = initialPosition.obs;
}

class HomeController extends GetxController {
  final tasks = <TaskModel>[].obs;
  final List<String> taskOrder = ['1', '2', '3', '4'];
  final isDragging = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeTasks();
  }

  void _initializeTasks() {
    tasks.assignAll([
      TaskModel(
        id: '1',
        task: "Pack and Prepare dad\nleave by 12pm",
        time: "12pm - 12:30pm   in 20min",
        color: AppColours.noteGreen,
        icon: Icons.backpack,
        initialPosition: const Offset(20, 20),
        rotation: -0.05,
      ),
      TaskModel(
        id: '2',
        task: "Reply WhatsApp\nmessages!!",
        time: "02pm - 03:30pm   in 1hr",
        color: AppColours.noteYellow,
        icon: Icons.phone_android,
        initialPosition: const Offset(150, 180),
        rotation: 0.05,
      ),
      TaskModel(
        id: '3',
        task: "Test responsiveness on\ntablet before standup",
        time: "04pm - 04:30pm",
        color: AppColours.notePink,
        icon: Icons.tablet_mac,
        initialPosition: const Offset(10, 400),
        rotation: -0.03,
      ),
      TaskModel(
        id: '4',
        task: "Create empty state\nillustrations for iPad app!!",
        time: "05pm - 05:30pm",
        color: AppColours.notePurple,
        icon: Icons.palette,
        initialPosition: const Offset(140, 620),
        rotation: 0.02,
      ),
    ]);
  }

  void updateTaskPosition(String id, Offset delta) {
    final task = tasks.firstWhere((t) => t.id == id);
    task.position.value += delta;
  }

  void moveToTop(String id) {
    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1 && index != tasks.length - 1) {
      final task = tasks.removeAt(index);
      tasks.add(task);
    }
  }

  void setDragging(bool value) {
    isDragging.value = value;
  }

  TaskModel getTaskById(String id) => tasks.firstWhere((t) => t.id == id);
}
