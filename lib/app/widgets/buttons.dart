import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/utils.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark
            ? AppColours.white.withValues(alpha: 0.2)
            : AppColours.black.withValues(alpha: 0.1);
    final iconColor = isDark ? AppColours.white : AppColours.black;

    return GestureDetector(
      onTap: onTap ?? () => Get.back(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.arrow_back_ios_new, color: iconColor, size: 18),
      ),
    );
  }
}
