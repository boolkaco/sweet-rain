import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/models/level_model.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:sweetbonanzarain/services/logger.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';
import 'package:flutter/material.dart';

class BasketBack extends PositionComponent with HasGameRef<BonanzaGame>, CollisionCallbacks {
  final AppCubit appCubit;
  final LevelModel level;

  BasketBack(this.appCubit, this.level) : super(anchor: Anchor.bottomCenter);

  final AudioService audioService = AudioService();
  late StreamSubscription<dynamic> _accelerometerSubscription;
  final double sensitivity = 2.0;
  double _movementSpeed = 0.0;

  late SpriteComponent _basketBack;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      _movementSpeed = event.x * sensitivity * 100;
    });

    final ImageComposition.Image? basketBack = await ImagesService().getImageByFilename(assetsMap['cart_back_${level.basketIndex}']!);

    if (basketBack != null) {
      _basketBack = SpriteComponent(
        sprite: Sprite(basketBack),
        size: Vector2(112, 39),
        anchor: Anchor.bottomCenter,
      );

      add(_basketBack);

      position =
          Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y - size.y / 2);
      _basketBack.position.y -= 47;

      final hitbox = RectangleHitbox(
        size: Vector2(132, 49),
      )..debugColor = Colors.blue;
      hitbox.position.y = -47;
      hitbox.position.x = -65;
      add(hitbox);
    } else {
      log.message('Error: Could not load sprites.');
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    double dx = -_movementSpeed * dt;
    position.x = (position.x + dx).clamp(0.0, gameRef.size.x - size.x);
  }

  double lerp(double start, double end, double percent) {
    return start + (end - start) * percent;
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
