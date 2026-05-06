import 'dart:ui';
import 'package:flutter/material.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Navigation Pill
        _buildLiquidGlassPill(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNavIcon(Icons.sort),
              const SizedBox(width: 8),
              _buildNavIcon(Icons.access_time),
            ],
          ),
        ),

        // Right Action Pill
        _buildLiquidGlassPill(
          isCircle: true,
          child: _buildNavIcon(Icons.add, size: 28),
        ),
      ],
    );
  }

  Widget _buildNavIcon(IconData icon, {double size = 24}) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Icon(icon, color: Colors.white, size: size),
    );
  }

  Widget _buildLiquidGlassPill({required Widget child, bool isCircle = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isCircle ? 40 : 32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(isCircle ? 40 : 32),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
