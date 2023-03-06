import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/fonts.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
                overflow: TextOverflow.fade,
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: SharedColors.homerBankWhiteColor),
            elevation: 0,
            color: SharedColors.homerBankPrimaryColor,
            iconTheme: IconThemeData(color: SharedColors.homerBankWhiteColor)),
        primaryColor: SharedColors.homerBankPrimaryColor,
        fontFamily: SharedFontFamily.lato,
        scaffoldBackgroundColor: SharedColors.homerBankWhiteColor);
  }
}

class ApplicationDefaultPixel {
  static double maxWidth = double.infinity;
  static double maxHeight = 926;
  static double minWidth = 428;
  static double minHeight = 926;
}
