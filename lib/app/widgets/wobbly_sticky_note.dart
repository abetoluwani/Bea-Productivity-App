import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WobblyStickyNote extends StatelessWidget {
  final String task;
  final String time;
  final Color color;
  final Widget? icon;
  final double rotation;

  const WobblyStickyNote({
    super.key,
    required this.task,
    required this.time,
    required this.color,
    this.icon,
    this.rotation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        painter: _StickyNotePainter(color: color),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      task,
                      style: GoogleFonts.patrickHand(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildPill(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, size: 12, color: Colors.black54),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: GoogleFonts.patrickHand(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPill(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class _StickyNotePainter extends CustomPainter {
  final Color color;

  _StickyNotePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    final random = Random(color.value + 100);

    double wobble() => (random.nextDouble() - 0.5) * 10;

    // Start point
    path.moveTo(wobble(), wobble());
    
    // Top edge
    path.quadraticBezierTo(size.width * 0.5 + wobble(), wobble() * 2, size.width + wobble(), wobble());
    
    // Right edge
    path.quadraticBezierTo(size.width + wobble() * 2, size.height * 0.5 + wobble(), size.width + wobble(), size.height + wobble());
    
    // Bottom edge
    path.quadraticBezierTo(size.width * 0.5 + wobble(), size.height + wobble() * 2, wobble(), size.height + wobble());
    
    // Left edge
    path.quadraticBezierTo(wobble() * 2, size.height * 0.5 + wobble(), wobble(), wobble());
    
    path.close();

    // Draw the main shape
    canvas.drawPath(path, paint);
    
    // Draw the border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
