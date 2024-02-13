import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';

class Levels {
  static List<LevelModel> list = [
    LevelModel(
      maxPlanet: 4,
      minSpeedPlanet: 100,
      maxSpeedPlanet: 300,
      backgroundUrl: assetsMap['level_1_bg']!,
      previewUrl: assetsMap['level_1_preview']!,
      isLock: false,
    ),
    LevelModel(
      maxPlanet: 3,
      minSpeedPlanet: 150,
      maxSpeedPlanet: 300,
      backgroundUrl: assetsMap['level_2_bg']!,
      previewUrl: assetsMap['level_2_preview']!,
      isLock: true,
    ),
    LevelModel(
      maxPlanet: 2,
      minSpeedPlanet: 200,
      maxSpeedPlanet: 300,
      backgroundUrl: assetsMap['level_3_bg']!,
      previewUrl: assetsMap['level_3_preview']!,
      isLock: true,
    ),
    LevelModel(
      maxPlanet: 2,
      minSpeedPlanet: 350,
      maxSpeedPlanet: 500,
      backgroundUrl: assetsMap['level_4_bg']!,
      previewUrl: assetsMap['level_4_preview']!,
      isLock: true,
    ),
  ];
}