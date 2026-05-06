import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiss_army_component/swiss_army_component.dart';

import 'colors.dart';

class AppTheme extends SACThemeBase {
  const AppTheme();

  @override
  SACThemeConfig? config() => SACThemeConfig(
    // Shared colors
    primary: AppColours.primary,
    secondary: AppColours.secondary,
    error: AppColours.red,

    // Light mode colors
    primaryLight: AppColours.primary,
    secondaryLight: AppColours.secondary,
    backgroundLight: AppColours.backgroundLight,
    surfaceLight: AppColours.surfaceLight,
    textPrimaryLight: AppColours.textPrimaryLight,
    textMutedLight: AppColours.textMutedLight,
    scaffoldBackgroundLight: AppColours.backgroundLight,
    appBarBackgroundLight: AppColours.surfaceLight,
    appBarForegroundLight: AppColours.textPrimaryLight,
    inputFillColorLight: AppColours.surfaceLight,

    // Dark mode colors
    primaryDark: AppColours.primary,
    secondaryDark: AppColours.secondary,
    backgroundDark: AppColours.backgroundDark,
    surfaceDark: AppColours.surfaceDark,
    borderDark: AppColours.borderDark,
    textPrimaryDark: AppColours.textPrimaryDark,
    textMutedDark: AppColours.textMutedDark,
    scaffoldBackgroundDark: AppColours.backgroundDark,
    appBarBackgroundDark: AppColours.surfaceDark,
    appBarForegroundDark: AppColours.textPrimaryDark,
    inputFillColorDark: AppColours.surfaceDark,

    // Component geometry and typography
    appBarElevation: 0,
    inputBorderRadius: 12,
    fontFamily: GoogleFonts.patrickHand().fontFamily,
    displayLarge: GoogleFonts.patrickHand(
      fontWeight: FontWeight.w700,
      fontSize: 32,
    ),
    headlineMedium: GoogleFonts.patrickHand(
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    titleLarge: GoogleFonts.patrickHand(
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    bodyMedium: GoogleFonts.patrickHand(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.patrickHand(
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelLarge: GoogleFonts.patrickHand(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  );
}

class GlobalAppTheme {
  static ThemeData get lighttheme => const AppTheme().light();

  static ThemeData get darkTheme => const AppTheme().dark();
}
