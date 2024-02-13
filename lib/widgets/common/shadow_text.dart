import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';

class ShadowText extends StatelessWidget {
  final String text;
  final Color color;
  final Color shadowColor;
  final double size;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const ShadowText(
    this.text, {
    super.key,
    this.color = AppColors.white,
    this.shadowColor = AppColors.sherpaBlue,
    this.size = 24,
    this.fontWeight = FontWeight.w900,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
        shadows: [
          Shadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: shadowColor,
          ),
        ],
      ),
    );
  }
}
