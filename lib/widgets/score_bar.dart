import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/common/stroke_text.dart';

class ScoreBar extends StatelessWidget {
  final int score;

  const ScoreBar({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    String formattedScore = score.toString().padLeft(4, '0');

    return Row(
      children: [
        Image.file(
          ImagesService().getByFilename(assetsMap['coin']!)!,
          width: 32,
          height: 32,
        ),
        const SizedBox(width: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 60,
          ),
          child: StrokeText(
            formattedScore,
            size: 24,
            fontWeight: FontWeight.w900,
            strokeWidth: 8,
          ),
        )
      ],
    );
  }
}
