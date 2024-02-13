// ignore_for_file: library_prefixes, implementation_imports

import 'dart:math';
import 'dart:ui' as ui;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/cannon.dart';
import 'package:sweetbonanzarain/widgets/game/moving_sweet.dart';

class BonanzoGame extends FlameGame with PanDetector, HasCollisionDetection {
  static final Random _random = Random();
  final LevelModel level;
  late Basket cannon;
  late int maxPlanets;
  final List<MovingSweet> planets = [];
  final Set<int> availablePlanets = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
  final AppCubit appCubit;
  double timeElapsed = 0.0;
  late Timer _spawnTimer;
  final double _minSpawnDelay = 1.0;
  final double _maxSpawnDelay = 2.0;

  BonanzoGame({
    required this.level,
    required this.appCubit,
  }) {
    maxPlanets = level.maxPlanet;
  }

  @override
  Future<void> onLoad() async {
    // final ImageComposition.Image? bg2 = await ImagesService().getImageByFilename(level.backgroundUrl);
    final ui.Image? bg2 =
        await ImagesService().loadImage('assets/images/bg_level_1.png');
    if (bg2 != null) {
      final sprite = Sprite(bg2);
      final spriteComponent = SpriteComponent(sprite: sprite, size: size);
      add(spriteComponent);
    }

    cannon = Basket(appCubit)..position = size / 2;
    add(cannon);

    spawnPlanet();
    startTimer();
    _setupSpawnTimer();
  }

  void _setupSpawnTimer() {
    final double spawnDelay = _random.nextDouble() * (_maxSpawnDelay - _minSpawnDelay) + _minSpawnDelay;
    _spawnTimer = Timer(spawnDelay, onTick: _spawnPlanet, repeat: true);
    _spawnTimer.start();
  }

  void _spawnPlanet() {
    if (planets.length < maxPlanets) {
      final index = availablePlanets.elementAt(_random.nextInt(availablePlanets.length));
      availablePlanets.remove(index);
      final movingSweet = MovingSweet(index, appCubit, verticalSpeed: 200);
      add(movingSweet);
      planets.add(movingSweet);
      _spawnTimer.stop();
      _setupSpawnTimer();
    }
  }

  void startTimer() {
    timeElapsed = 0.0;
  }

  void updateTimer(double dt) {
    timeElapsed += dt;
  }

  void finishLevel(bool isWon) {
    int stars;
    if (timeElapsed <= 10) {
      stars = 3;
    } else if (timeElapsed <= 20) {
      stars = 2;
    } else {
      stars = 0;
    }
    if (!isWon) {
      stars = 0;
    }
    appCubit.finishLevel(level, stars);
  }

  void spawnPlanet() {
    if (planets.isEmpty && availablePlanets.isNotEmpty) {
      final index = availablePlanets.elementAt(
        _random.nextInt(availablePlanets.length),
      );
      availablePlanets.remove(index);
      final movingSweet = MovingSweet(
        index,
        appCubit,
        verticalSpeed: 200,
      );
      add(movingSweet);
      planets.add(movingSweet);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateTimer(dt);
    _spawnTimer.update(dt);
    planets.removeWhere((planet) => planet.isRemoved);
    if (planets.length < maxPlanets) {
      spawnPlanet();
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    cannon.move(info.delta.global);
  }
}
