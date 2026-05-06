import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../../../utils/theme/colors.dart';
import '../../../widgets/hand_drawn_shapes.dart';
import '../../../widgets/wobbly_sticky_note.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigAppText(
                          'Hello Bea',
                          fontSize: 48,
                          color: AppColours.white,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "You've got 6 tasks\nto complete today..",
                          style: GoogleFonts.patrickHand(
                            fontSize: 30,
                            color: AppColours.grey,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                    Image.asset('assets/images/flower.png', width: 120, height: 120),
                  ],
                ),
                const SizedBox(height: 40),
                _buildFilterChips(),
                const SizedBox(height: 30),
                _buildTasks(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white12,
        elevation: 0,
        shape: CircleBorder(side: BorderSide(color: Colors.white.withOpacity(0.1))),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
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

  Widget _buildTasks() {
    return Column(
      children: [
        _buildTaskItem(
          WobblyStickyNote(
            task: "Pack and Prepare dad\nleave by 12pm",
            time: "12pm - 12:30pm   in 20min",
            color: AppColours.noteGreen,
            rotation: -0.05,
            icon: const Icon(Icons.backpack, color: Colors.redAccent, size: 30),
          ),
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(height: 20),
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildTaskItem(
              WobblyStickyNote(
                task: "Reply WhatsApp\nmessages!!",
                time: "02pm - 03:30pm   in 1hr",
                color: AppColours.noteYellow,
                rotation: 0.05,
                icon: const Icon(Icons.phone_android, color: Colors.black87, size: 30),
              ),
              alignment: Alignment.centerRight,
            ),
            const Positioned(
              top: -30,
              right: 60,
              child: Butterfly(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildTaskItem(
          WobblyStickyNote(
            task: "Test responsiveness on\ntablet before standup",
            time: "04pm - 04:30pm",
            color: AppColours.notePink,
            rotation: -0.03,
            icon: const Icon(Icons.tablet_mac, color: Colors.black87, size: 30),
          ),
          alignment: Alignment.centerLeft,
        ),
        const SizedBox(height: 20),
        _buildTaskItem(
          WobblyStickyNote(
            task: "Create empty state\nillustrations for iPad app!!",
            time: "05pm - 05:30pm",
            color: AppColours.notePurple,
            rotation: 0.02,
            icon: const Icon(Icons.palette, color: Colors.orangeAccent, size: 30),
          ),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }

  Widget _buildTaskItem(Widget child, {required Alignment alignment}) {
    return Align(
      alignment: alignment,
      child: child,
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: Colors.transparent,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu, color: Colors.white54, size: 28)),
          const SizedBox(width: 20),
          IconButton(onPressed: () {}, icon: const Icon(Icons.access_time, color: Colors.white54, size: 28)),
        ],
      ),
    );
  }
}
