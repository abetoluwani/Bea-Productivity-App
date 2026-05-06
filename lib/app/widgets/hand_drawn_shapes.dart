import 'dart:math';
import 'package:flutter/material.dart';

class HandDrawnFlower extends StatelessWidget {
  final Color color;
  final double size;

  const HandDrawnFlower({super.key, this.color = Colors.blue, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _FlowerPainter(color: color),
    );
  }
}

class _FlowerPainter extends CustomPainter {
  final Color color;
  _FlowerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 4;

    // Draw petals
    for (int i = 0; i < 5; i++) {
      final angle = i * 2 * pi / 5;
      final petalCenter = Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      );
      canvas.drawCircle(petalCenter, radius, paint);
    }

    // Draw center
    canvas.drawCircle(center, radius * 0.8, Paint()..color = Colors.yellow);
    canvas.drawCircle(center, radius * 0.8, paint);

    // Draw face
    final eyePaint = Paint()..color = Colors.black..style = PaintingStyle.fill;
    canvas.drawCircle(center.translate(-radius * 0.3, -radius * 0.1), 2, eyePaint);
    canvas.drawCircle(center.translate(radius * 0.3, -radius * 0.1), 2, eyePaint);
    
    final mouthPath = Path()
      ..addArc(Rect.fromCircle(center: center.translate(0, 2), radius: radius * 0.4), 0.2, pi - 0.4);
    canvas.drawPath(mouthPath, paint..strokeWidth = 2);

    // Draw stem
    final stemPaint = Paint()..color = Colors.green..strokeWidth = 4..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final stemPath = Path()
      ..moveTo(center.dx, center.dy + radius * 2)
      ..quadraticBezierTo(center.dx - 10, center.dy + radius * 4, center.dx, center.dy + radius * 6);
    canvas.drawPath(stemPath, stemPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SquigglyArrow extends StatelessWidget {
  final Offset start;
  final Offset end;
  final Color color;

  const SquigglyArrow({super.key, required this.start, required this.end, this.color = Colors.white54});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SquigglyArrowPainter(start: start, end: end, color: color),
    );
  }
}

class _SquigglyArrowPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;

  _SquigglyArrowPainter({required this.start, required this.end, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(start.dx, start.dy);
    
    final midX = (start.dx + end.dx) / 2;
    final midY = (start.dy + end.dy) / 2;
    
    path.quadraticBezierTo(midX + 20, midY - 20, end.dx, end.dy);
    
    // Draw arrowhead
    final angle = atan2(end.dy - start.dy, end.dx - start.dx);
    path.moveTo(end.dx, end.dy);
    path.lineTo(end.dx - 10 * cos(angle - pi / 6), end.dy - 10 * sin(angle - pi / 6));
    path.moveTo(end.dx, end.dy);
    path.lineTo(end.dx - 10 * cos(angle + pi / 6), end.dy - 10 * sin(angle + pi / 6));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Butterfly extends StatelessWidget {
  final double size;
  const Butterfly({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ButterflyPainter(),
    );
  }
}

class _ButterflyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw wings (loops)
    final path = Path();
    path.moveTo(center.dx, center.dy);
    path.cubicTo(center.dx - 15, center.dy - 15, center.dx - 15, center.dy + 15, center.dx, center.dy);
    path.cubicTo(center.dx + 15, center.dy - 15, center.dx + 15, center.dy + 15, center.dx, center.dy);
    
    canvas.drawPath(path, paint);
    
    // Draw body
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: 4, height: 12), const Radius.circular(2)),
      Paint()..color = Colors.yellow..style = PaintingStyle.fill,
    );
    
    // Draw hat
    final hatPath = Path()
      ..moveTo(center.dx - 4, center.dy - 6)
      ..lineTo(center.dx + 4, center.dy - 6)
      ..lineTo(center.dx, center.dy - 14)
      ..close();
    canvas.drawPath(hatPath, Paint()..color = Colors.pinkAccent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
