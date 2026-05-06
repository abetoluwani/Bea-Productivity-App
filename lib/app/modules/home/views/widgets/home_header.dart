import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiss_army_component/swiss_army_component.dart';
import '../../../../utils/theme/colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
