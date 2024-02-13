import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';

class Levels {
  static List<LevelModel> list = [
    // TODO: assetsMap['level_1_bg']! & assetsMap['level_1_preview']!
    LevelModel(
      maxPlanet: 4,
      minSpeedPlanet: 100,
      maxSpeedPlanet: 300,
      backgroundUrl: '',
      previewUrl: '',
      isLock: false,
    ),
    LevelModel(
      maxPlanet: 3,
      minSpeedPlanet: 150,
      maxSpeedPlanet: 300,
      backgroundUrl: '',
      previewUrl: '',
      isLock: true,
    ),
    LevelModel(
      maxPlanet: 2,
      minSpeedPlanet: 200,
      maxSpeedPlanet: 300,
      backgroundUrl: '',
      previewUrl: '',
      isLock: true,
    ),
    LevelModel(
      maxPlanet: 2,
      minSpeedPlanet: 350,
      maxSpeedPlanet: 500,
      backgroundUrl: '',
      previewUrl: '',
      isLock: true,
    ),
  ];
}