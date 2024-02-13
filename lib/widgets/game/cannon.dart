// ignore_for_file: library_prefixes, implementation_imports

import 'dart:ui' as ui;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/bonanzo_game.dart';
import 'package:sweetbonanzarain/services/logger.dart';

class Basket extends PositionComponent
    with HasGameRef<BonanzoGame>, CollisionCallbacks {
  late SpriteComponent _cannonBase;
  late SpriteComponent _cannonTop;
  final AppCubit appCubit;

  Basket(this.appCubit) : super(anchor: Anchor.bottomCenter);

  final AudioService audioService = AudioService();

  bool _isBallLoaded = true;

  void reload() async {
    if (!_isBallLoaded) {
      _isBallLoaded = true;
      add(_cannonTop);
    }
  }

  @override
  Future<void> onLoad() async {
    final ui.Image gunBackImage = await ImagesService().loadImage(
      'assets/images/basket_top.png',
    );
    final ui.Image gunImage = await ImagesService().loadImage(
      'assets/images/basket_bottom.png',
    );

    add(RectangleHitbox(size: Vector2(112, 70)));


    if (gunBackImage != null && gunImage != null) {
      _cannonBase = SpriteComponent(
        sprite: Sprite(gunBackImage),
        size: Vector2(112, 39),
        anchor: Anchor.bottomCenter,
      );
      _cannonTop = SpriteComponent(
        sprite: Sprite(gunImage),
        size: Vector2(112, 70),
        anchor: Anchor.bottomCenter,
      );

      add(_cannonBase);
      add(_cannonTop);

      _cannonBase.position.y -= 47;
      position =
          Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y - size.y / 2);
    } else {
      log.message('Error: Could not load sprites.');
    }
  }

  void move(Vector2 delta) {
    position.add(Vector2(delta.x, 0));

    double newX =
        position.x.clamp(size.x / 2, gameRef.size.x - size.x / 2).toDouble();
    position.x = newX;
  }
}
