import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiss_army_component/widgets/apptext.dart';

import '../utils/utils.dart';

class AppLoadingScreen extends StatelessWidget {
  final String? message;

  const AppLoadingScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor.withValues(alpha: 0.9),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColours.primary),
            ),

            if (message != null) ...[
              SizedBox(height: 24.h),
              MedAppText(
                message!,
                fontSize: 14.sp,
                color: AppColours.grey,
                alignment: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
