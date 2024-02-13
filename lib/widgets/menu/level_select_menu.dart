import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';

class LevelSelectMenu extends StatelessWidget {
  final String backgroundUrl;
  final bool isRightPlay;
  final bool isLock;
  final int score;
  final Function() onTap;

  const LevelSelectMenu({
    super.key,
    required this.backgroundUrl,
    required this.onTap,
    required this.isLock,
    this.isRightPlay = true,
    this.score = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: isRightPlay ? Alignment.centerRight : Alignment.centerLeft,
        child: Stack(
          children: [
            Image.asset(
              backgroundUrl,
              fit: BoxFit.cover,
            ),
            if (isLock)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/lock.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}