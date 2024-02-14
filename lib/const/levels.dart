import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';

class Levels {
  static List<LevelModel> list = [
    LevelModel(
      maxSweets: 4,
      basketIndex: 1,
      backgroundUrl: assetsMap['level_1_bg']!,
      previewUrl: assetsMap['level_1_preview']!,
      isLock: false,
    ),
    LevelModel(
      maxSweets: 4,
      basketIndex: 2,
      backgroundUrl: assetsMap['level_2_bg']!,
      previewUrl: assetsMap['level_2_preview']!,
      isLock: true,
    ),
    LevelModel(
      maxSweets: 4,
      basketIndex: 3,
      backgroundUrl: assetsMap['level_3_bg']!,
      previewUrl: assetsMap['level_3_preview']!,
      isLock: true,
    ),
    LevelModel(
      maxSweets: 4,
      backgroundUrl: assetsMap['level_4_bg']!,
      previewUrl: assetsMap['level_4_preview']!,
      isLock: true,
    ),
  ];
}