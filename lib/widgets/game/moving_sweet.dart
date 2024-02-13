import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:sweetbonanzarain/widgets/game/cannon.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/bonanzo_game.dart';

class MovingSweet extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BonanzoGame> {
  static final Random _random = Random();
  final int imageIndex;
  final AppCubit appCubit;
  final double verticalSpeed;

  MovingSweet(
    this.imageIndex,
    this.appCubit, {
    required this.verticalSpeed,
  }) : super(
          anchor: Anchor.center,
          size: Vector2(100.0, 140),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final imageIndex = _random.nextInt(10) + 1;
    // final Image? planetImage = await ImagesService().getImageByFilename(
    //   assetsMap['planet_$imageIndex']!,
    // );
    final ui.Image? planetImage =
      await ImagesService().loadImage('assets/images/img_$imageIndex.png');
    sprite = Sprite(planetImage!);

    final screenWidth = gameRef.size.x;
    final planetWidth = size.x;

    final double horizontalPosition =
        _random.nextDouble() * (screenWidth - planetWidth) + planetWidth / 2;

    position = Vector2(horizontalPosition, -size.y);

    final hitbox = CircleHitbox(radius: size.x / 2);
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += verticalSpeed * dt;

    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    gameRef.availablePlanets.add(imageIndex);
    gameRef.spawnPlanet();
  }

  @override
  Future<void> onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Basket) {
      appCubit.addScore(
        100,
      );
      removeFromParent();
    }
  }
}
