import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle getTextStyle({
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.black,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle get t10b500_3AF => getTextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.neutralGrey3AF,
      );

  static TextStyle get t10b500_80C => getTextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.warningOrange80C,
      );

  static TextStyle get t10b500_FFF => getTextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle get t12b400_937 => getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.neutralGrey937,
      );

  static TextStyle get t12b400_280 => getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.neutralGrey280,
      );

  static TextStyle get t12b500_937 => getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.neutralGrey937,
      );

  static TextStyle get t14b400_937 => getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.neutralGrey937,
      );

  static TextStyle get t14b600_937 => getTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.neutralGrey937,
  );

  static TextStyle get t16b400_000 => getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );

  static TextStyle get t16b400_3AF => getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.neutralGrey3AF,
      );

  static TextStyle get t16b400_937 => getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.neutralGrey937,
      );

  static TextStyle get t16b600_937 => getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.neutralGrey937,
      );
}
