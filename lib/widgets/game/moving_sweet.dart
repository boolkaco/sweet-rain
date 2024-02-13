import 'dart:math';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/widgets/game/basket.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;

class MovingSweet extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BonanzaGame> {
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

    final imageIndex = _random.nextInt(11) + 1;
    final ImageComposition.Image? sweetImage =
      await ImagesService().getImageByFilename(assetsMap['sweet_$imageIndex']!);
    sprite = Sprite(sweetImage!);

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
    gameRef.availableSweets.add(imageIndex);
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
