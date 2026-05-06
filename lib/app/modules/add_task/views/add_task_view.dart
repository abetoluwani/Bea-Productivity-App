import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/parallelogram_clipper.dart';
import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent.withValues(alpha: 0.05),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildLabel("Task Title"),
                  _buildInputField(
                    controller: controller.titleController,
                    hint: "What's on your mind?",
                  ),
                  const SizedBox(height: 30),
                  _buildLabel("Time Range"),
                  _buildInputField(
                    controller: controller.timeController,
                    hint: "e.g. 12pm - 01:30pm",
                  ),
                  const SizedBox(height: 30),
                  _buildLabel("Pick a Color"),
                  _buildColorPicker(),
                  const SizedBox(height: 30),
                  _buildLabel("Pick an Icon"),
                  _buildIconPicker(),
                  const SizedBox(height: 60),
                  _buildCreateButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: _buildGlassCircle(Icons.arrow_back_ios_new),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          ClipPath(
            clipper: ParallelogramClipper(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              color: const Color(0xFF00B4D8),
              child: Text(
                "Create New Task",
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Plan your day beautifully",
            style: GoogleFonts.patrickHand(color: Colors.white54, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        text,
        style: GoogleFonts.patrickHand(
          color: Colors.white70,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: TextField(
            controller: controller,
            style: GoogleFonts.fredoka(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.fredoka(
                color: Colors.white24,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.all(20),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return SizedBox(
      height: 60,
      child: Obx(() {
        // Access observable to register dependency
        controller.selectedColor.value;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.availableColors.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final color = controller.availableColors[index];
            final isSelected = controller.selectedColor.value == color;
            return GestureDetector(
              onTap: () => controller.selectedColor.value = color,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 3)
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ]
                      : null,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildIconPicker() {
    return SizedBox(
      height: 60,
      child: Obx(() {
        // Access observable to register dependency
        controller.selectedIcon.value;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.availableIcons.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final icon = controller.availableIcons[index];
            final isSelected = controller.selectedIcon.value == icon;
            return GestureDetector(
              onTap: () => controller.selectedIcon.value = icon,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 2)
                      : null,
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildCreateButton() {
    return Center(
      child: GestureDetector(
        onTap: () => controller.createTask(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF00B4D8).withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Text(
                "Add to Deck",
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCircle(IconData icon) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
