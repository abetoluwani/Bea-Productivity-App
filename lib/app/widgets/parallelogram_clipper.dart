import 'package:flutter/material.dart';

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const double slant1 = 5.0;
    const double slant2 = 30.0;

    path.moveTo(slant1, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - slant2, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
