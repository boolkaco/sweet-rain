import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/theme/app_theme.dart';

enum AppThemeType { light, dark }

class ThemeNotifier with ChangeNotifier {
  AppThemeType _currentThemeType = AppThemeType.light;

  ThemeData get currentTheme {
    return _currentThemeType == AppThemeType.light
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;
  }

  AppThemeType get currentThemeType => _currentThemeType;

  void switchTheme() {
    _currentThemeType = _currentThemeType == AppThemeType.light
        ? AppThemeType.dark
        : AppThemeType.light;
    notifyListeners();
  }
}
