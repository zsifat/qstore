import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qstore/core/theme/app_textstyles.dart';

import '../theme/app_colors.dart';

class LottieDisplay extends StatelessWidget {
  final String animationPath;
  final String message;
  final double animationSize;
  final TextStyle? textStyle;

  const LottieDisplay({
    super.key,
    required this.animationPath,
    required this.message,
    this.animationSize = 120,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            animationPath,
            width: animationSize,
            height: animationSize,
            repeat: true,
            reverse: false,
            animate: true,
            fit: BoxFit.contain,
            frameRate: FrameRate.max,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox();
            },
          ),
          Text(
            message,
            style: textStyle ?? AppTextStyles.t14b400_937,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

void showNoInternetSnackbar(BuildContext context) {
  final snackBar = SnackBar(
    content: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, color: Colors.white),
          SizedBox(width: 10),
          Expanded(child: Text("No internet connection", style: GoogleFonts.inter(fontSize: 16,color: Colors.white))),
        ],
      ),
    ),
    backgroundColor: AppColors.warningOrange80C,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}