import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/theme/app_colors.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final Color color;
  final Color strokeColor;
  final double size;
  final double strokeWidth;
  final FontWeight fontWeight;

  const StrokeText(
    this.text, {
    super.key,
    this.color = AppColors.white,
    this.strokeColor = AppColors.aqua,
    this.size = 30,
    this.strokeWidth = 6,
    this.fontWeight = FontWeight.w800,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: size,
                fontWeight: fontWeight,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..color = strokeColor,
              ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: size,
                fontWeight: fontWeight,
                color: color,
              ),
        )
      ],
    );
  }
}
