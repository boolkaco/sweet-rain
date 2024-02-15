import 'package:flutter/material.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';

class HeartsBar extends StatelessWidget {
  final int filledHearts;

  const HeartsBar({super.key, required this.filledHearts});

  @override
  Widget build(BuildContext context) {
    final outlineImage =
        ImagesService().getByFilename(assetsMap['outline_like']!);
    final filledImage =
        ImagesService().getByFilename(assetsMap['filled_like']!);

    return SizedBox(
      height: 25,
      width: 90,
      child: Stack(
        children: [
          for (int i = 0; i < 3; i++)
            Positioned(
              left: i * 22.0,
              child: Image.file(
                outlineImage!,
                width: 30,
                height: 25,
              ),
            ),
          if (filledHearts > 0)
            for (int i = 0; i < filledHearts; i++)
              Positioned(
                left: i * 22.0,
                child: Image.file(
                  filledImage!,
                  width: 30,
                  height: 25,
                ),
              ),
        ],
      ),
    );
  }
}
