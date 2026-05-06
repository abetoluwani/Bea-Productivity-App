import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import '../utils/utils.dart';
import 'buttons.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    this.showBackButton = true,
    required this.title,
    required this.description,
    required this.imageAsset,
    this.buttonLabel,
    required this.onButtonPressed,
    this.showDecorations = true,
  });
  final bool showBackButton;
  final String title;
  final String description;
  final String imageAsset;
  final String? buttonLabel;
  final VoidCallback onButtonPressed;
  final bool showDecorations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (showBackButton)
              Padding(
                padding: EdgeInsets.only(
                  top: 15.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 10.h,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const AppBackButton(),
                ),
              ),

            // Main Content
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: simPad(20.w, 16.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          if (showDecorations) ...[
                            Positioned(
                              top: 0,
                              left: -20.w,
                              child: Icon(
                                Icons.star,
                                size: 16.sp,
                                color: AppColours.primary,
                              ),
                            ),
                             Positioned(
                              top: 40.h,
                              right: -30.w,
                              child: Container(
                                width: 8.sp,
                                height: 8.sp,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyLarge?.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            // Bottom decoration (Star)
                            Positioned(
                              bottom: 10.h,
                              left: -10.w,
                              child: Icon(
                                Icons.star,
                                size: 14.sp,
                                color: AppColours.secondary,
                              ),
                            ),
                          ],
                          // Main image
                          Image.asset(
                            imageAsset,
                            width: 140.sp,
                            height: 140.sp,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),

                      // Title
                      BigAppText(
                        title,
                        alignment: TextAlign.center,
                        fontSize: 32.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      vSpace(20),
                      // Description
                      MedAppText(
                        description,
                        alignment: TextAlign.center,
                        color: AppColours.grey,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Button at bottom
            Padding(
              padding: EdgeInsets.all(20.w),
              child: AppElevatedButton(
                title: buttonLabel ?? 'Proceed',
                onPressed: onButtonPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
