// ignore_for_file: library_prefixes, implementation_imports

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/basket.dart';
import 'package:sweetbonanzarain/widgets/game/moving_clouds_components.dart';
import 'package:sweetbonanzarain/widgets/game/moving_sweet.dart';

class BonanzaGame extends FlameGame with PanDetector, HasCollisionDetection {
  static final Random _random = Random();
  final LevelModel level;
  late Basket basket;
  late int maxSweets;
  final List<MovingSweet> sweets = [];
  final Set<int> availableSweets = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
  final AppCubit appCubit;
  double timeElapsed = 0.0;
  bool isSpawningActive = true;
  late Timer _spawnTimer;
  final double _minSpawnDelay = 1.0;
  final double _maxSpawnDelay = 2.0;

  BonanzaGame({
    required this.level,
    required this.appCubit,
  }) {
    maxSweets = level.maxSweets;
  }

  @override
  Future<void> onLoad() async {
    final ImageComposition.Image? bg =
        await ImagesService().getImageByFilename(level.backgroundUrl);
    final ImageComposition.Image? cloudsImage =
        await ImagesService().getImageByFilename(assetsMap['clouds']!);
    final cloudSprite = Sprite(cloudsImage!);

    if (bg != null) {
      final sprite = Sprite(bg);
      final spriteComponent = SpriteComponent(sprite: sprite, size: size);
      add(spriteComponent);
    }

    basket = Basket(appCubit, level)..position = size / 2;
    add(basket);

    // spawnSweets();
    startTimer();
    _setupSpawnTimer();

    final movingClouds = MovingCloudsComponent(
      cloudSprite: cloudSprite,
      speed: 20.0,
    );
    add(movingClouds);
  }

  void _setupSpawnTimer() {
    final double spawnDelay =
        _random.nextDouble() * (_maxSpawnDelay - _minSpawnDelay) +
            _minSpawnDelay;
    _spawnTimer = Timer(spawnDelay, onTick: _spawnSweets, repeat: true);
    _spawnTimer.start();
  }

  void _spawnSweets() {
    if (isSpawningActive && sweets.length < maxSweets) {
      final index =
          availableSweets.elementAt(_random.nextInt(availableSweets.length));
      availableSweets.remove(index);
      final movingSweet = MovingSweet(
        index,
        appCubit,
        verticalSpeed: level.speed,
      );
      add(movingSweet);
      sweets.add(movingSweet);
      if (isSpawningActive) {
        _spawnTimer.stop();
        _setupSpawnTimer();
      }
    }
  }

  void stopSpawning() {
    isSpawningActive = false;
    _spawnTimer.stop();
  }

  void startSpawning() {
    if (!isSpawningActive) {
      isSpawningActive = true;
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
    stopSpawning();
    appCubit.finishLevel(level, isWon);
  }

  void spawnSweets() {
    if (sweets.isEmpty && availableSweets.isNotEmpty) {
      final index = availableSweets.elementAt(
        _random.nextInt(availableSweets.length),
      );
      availableSweets.remove(index);
      final movingSweet = MovingSweet(
        index,
        appCubit,
        verticalSpeed: level.speed,
      );
      add(movingSweet);
      sweets.add(movingSweet);
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    basket.move(info.delta.global);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateTimer(dt);
    _spawnTimer.update(dt);
    sweets.removeWhere((planet) => planet.isRemoved);
    if (sweets.length < maxSweets) {
      spawnSweets();
    }
  }
}
