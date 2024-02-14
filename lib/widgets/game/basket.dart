// ignore_for_file: library_prefixes, implementation_imports

import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';
import 'package:sweetbonanzarain/services/logger.dart';

class Basket extends PositionComponent
    with HasGameRef<BonanzaGame>, CollisionCallbacks {
  late SpriteComponent _basketBack;
  late SpriteComponent _basketFront;
  final AppCubit appCubit;
  final LevelModel level;

  Basket(this.appCubit, this.level) : super(anchor: Anchor.bottomCenter);

  final AudioService audioService = AudioService();
  late StreamSubscription<dynamic> _accelerometerSubscription;
  double _lastUpdate = 0;
  final double _updateInterval = 1 / 60;

  @override
  Future<void> onLoad() async {
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      final double now = DateTime.now().millisecondsSinceEpoch / 1000;
      if (now - _lastUpdate > _updateInterval) {
        final movementSpeed = event.x * -2;
        move(Vector2(movementSpeed, 0));
        _lastUpdate = now;
      }
    });

    final ImageComposition.Image? basketFront = await ImagesService()
        .getImageByFilename(assetsMap['cart_front_${level.basketIndex}']!);

    final ImageComposition.Image? basketBack = await ImagesService()
        .getImageByFilename(assetsMap['cart_back_${level.basketIndex}']!);

    add(RectangleHitbox(size: Vector2(100, 50)));

    if (basketFront != null && basketBack != null) {
      _basketBack = SpriteComponent(
        sprite: Sprite(basketBack),
        size: Vector2(112, 39),
        anchor: Anchor.bottomCenter,
      );
      _basketFront = SpriteComponent(
        sprite: Sprite(basketFront),
        size: Vector2(112, 70),
        anchor: Anchor.bottomCenter,
      );

      add(_basketBack);
      add(_basketFront);

      _basketBack.position.y -= 47;
      position =
          Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y - size.y / 2);
    } else {
      log.message('Error: Could not load sprites.');
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    _accelerometerSubscription.cancel();
  }

  void move(Vector2 delta) {
    position.add(Vector2(delta.x, 0));

    double newX =
        position.x.clamp(size.x / 2, gameRef.size.x - size.x / 2).toDouble();
    position.x = newX;
  }
}
