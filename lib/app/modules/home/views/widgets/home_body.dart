import 'package:bea/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiss_army_component/widgets/widget.dart';
import '../../../../widgets/hand_drawn_shapes.dart';
import '../../../../widgets/parallelogram_clipper.dart';
import '../../../../widgets/wobbly_sticky_note.dart';
import 'home_header.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        physics: controller.isDragging.value
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        child: Padding(
          padding: simPad(0, 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpace(20),
              const HomeHeader(),
              vSpace(40),
              _buildFilterChips(),
              vSpace(30),
              SizedBox(
                height: 1200,
                width: double.infinity,
                child: Obx(() {
                  if (controller.tasks.isEmpty) {
                    return _buildEmptyState();
                  }
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ..._buildArrows(),
                      ...controller.tasks.map(
                        (task) => _buildDraggableTask(task),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildArrows() {
    final List<Widget> arrowWidgets = [];
    for (int i = 0; i < controller.taskOrder.length - 1; i++) {
      final startTask = controller.getTaskById(controller.taskOrder[i]);
      final endTask = controller.getTaskById(controller.taskOrder[i + 1]);

      final startPoints = _getCardEdgePoints(startTask.position.value);
      final endPoints = _getCardEdgePoints(endTask.position.value);

      Offset bestStart = startPoints[0];
      Offset bestEnd = endPoints[0];
      double minDistance = double.infinity;

      for (var p1 in startPoints) {
        for (var p2 in endPoints) {
          final dist = (p1 - p2).distance;
          if (dist < minDistance) {
            minDistance = dist;
            bestStart = p1;
            bestEnd = p2;
          }
        }
      }

      final direction = (bestEnd - bestStart).direction;
      final gapStart = bestStart + Offset.fromDirection(direction, 20);
      final gapEnd = bestEnd + Offset.fromDirection(direction + 3.14159, 20);

      arrowWidgets.add(
        SquigglyArrow(
          key: ValueKey('arrow_${startTask.id}_${endTask.id}'),
          start: gapStart,
          end: gapEnd,
          color: Colors.pinkAccent.withValues(alpha: 0.25),
        ),
      );
    }
    return arrowWidgets;
  }

  List<Offset> _getCardEdgePoints(Offset pos) {
    const width = 180.0;
    const height = 120.0;
    return [
      pos + const Offset(width / 2, 0),
      pos + const Offset(width / 2, height),
      pos + const Offset(0, height / 2),
      pos + const Offset(width, height / 2),
    ];
  }

  Widget _buildDraggableTask(TaskModel task) {
    return Obx(
      () => Positioned(
        key: ValueKey(task.id),
        left: task.position.value.dx,
        top: task.position.value.dy,
        child: Listener(
          onPointerDown: (_) => controller.setDragging(true),
          onPointerUp: (_) => controller.setDragging(false),
          onPointerCancel: (_) => controller.setDragging(false),
          child: GestureDetector(
            onPanStart: (_) {
              controller.moveToTop(task.id);
            },
            onPanEnd: (_) => controller.setDragging(false),
            onPanCancel: () => controller.setDragging(false),
            onPanUpdate: (details) {
              controller.updateTaskPosition(task.id, details.delta);
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                WobblyStickyNote(
                  task: task.task,
                  time: task.time,
                  color: task.color,
                  rotation: task.rotation,
                  icon: Icon(task.icon, color: Colors.black87, size: 30),
                ),
                if (task.id == '2')
                  const Positioned(top: -30, right: 20, child: Butterfly()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Center(
      child: ClipPath(
        clipper: ParallelogramClipper(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          color: const Color(0xFF00B4D8),
          child: Text(
            "What's on deck today",
            style: GoogleFonts.fredoka(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // Flower Icon
          const Icon(Icons.local_florist, size: 120, color: Color(0xFFFFD166)),
          const SizedBox(height: 40),
          Text(
            "You've got a quite day today.. 🐰",
            style: GoogleFonts.patrickHand(
              color: Colors.white70,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Rest and recharge",
            style: GoogleFonts.patrickHand(color: Colors.white38, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
