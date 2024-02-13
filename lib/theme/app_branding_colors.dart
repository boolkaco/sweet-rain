import 'package:flutter/material.dart';

@immutable
class AppBrandingColors extends ThemeExtension<AppBrandingColors> {
  const AppBrandingColors({
    required this.color,
  });

  final Color? color;

  @override
  AppBrandingColors copyWith({Color? color}) {
    return AppBrandingColors(
      color: color ?? this.color,
    );
  }

  @override
  AppBrandingColors lerp(AppBrandingColors? other, double t) {
    if (other is! AppBrandingColors) {
      return this;
    }
    return AppBrandingColors(
      color: Color.lerp(color, other.color, t),
    );
  }
}