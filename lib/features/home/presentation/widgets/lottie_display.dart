import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qstore/core/theme/app_textstyles.dart';

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