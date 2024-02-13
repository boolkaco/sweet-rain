import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.cover,
      width: 264,
      height: 226,
    );
  }
}
