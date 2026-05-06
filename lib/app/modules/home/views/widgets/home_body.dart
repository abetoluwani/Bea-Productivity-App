import 'package:bea/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../widgets/hand_drawn_shapes.dart';
import '../../../../widgets/wobbly_sticky_note.dart';
import 'home_header.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          physics: controller.isDragging.value
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const HomeHeader(),
                const SizedBox(height: 40),
                _buildFilterChips(),
                const SizedBox(height: 30),
                SizedBox(
                  height: 1000,
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ..._buildArrows(),
                      ...controller.tasks.map(
                        (task) => _buildDraggableTask(task),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 140),
              ],
            ),
          ),
        ));
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
          color: Colors.pinkAccent.withOpacity(0.25),
        ),
      );
    }
    return arrowWidgets;
  }

  List<Offset> _getCardEdgePoints(Offset pos) {
    const width = 220.0;
    const height = 140.0;
    return [
      pos + const Offset(width / 2, 0),
      pos + const Offset(width / 2, height),
      pos + const Offset(0, height / 2),
      pos + const Offset(width, height / 2),
    ];
  }

  Widget _buildDraggableTask(TaskModel task) {
    return Obx(() => Positioned(
          key: ValueKey(task.id), // CRITICAL: Keep the identity of the task
          left: task.position.value.dx,
          top: task.position.value.dy,
          child: GestureDetector(
            onPanStart: (_) {
              controller.setDragging(true);
              controller.moveToTop(task.id); // Only reorder ONCE when starting drag
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
        ));
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF00B4D8),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        "What's on deck today",
        style: GoogleFonts.patrickHand(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
