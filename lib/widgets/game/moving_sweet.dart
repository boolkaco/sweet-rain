import 'dart:math';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/basket_front.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';
import 'package:flame/src/image_composition.dart' as ImageComposition;

class MovingSweet extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BonanzaGame> {
  static final Random _random = Random();
  final int imageIndex;
  final AppCubit appCubit;
  final double verticalSpeed;
  final AudioService audioService = AudioService();
  late int tempIndex;
  bool isCollidedWithBasket = false;

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
    tempIndex = imageIndex;
    final ImageComposition.Image? sweetImage = await ImagesService()
        .getImageByFilename(assetsMap['sweet_$imageIndex']!);
    sprite = Sprite(sweetImage!);

    final screenWidth = gameRef.size.x;
    final planetWidth = size.x;

    final double horizontalPosition =
        _random.nextDouble() * (screenWidth - planetWidth) + planetWidth / 2;

    position = Vector2(horizontalPosition, -size.y);
    priority = 1;

    final hitbox = CircleHitbox(radius: size.x / 2);
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += verticalSpeed * dt;
    priority = 1;

    final basket = gameRef.basketFront;

    if (isCollidedWithBasket) {
      if (position.y > basket.position.y + basket.size.y) {
        if (!isRemoved) {
          removeFromParent();
        }
      }
    } else if (position.y > gameRef.size.y && !isRemoved) {
      onFallenOutside();
      if (!isRemoved) {
        removeFromParent();
      }
    }
  }

  void onFallenOutside() {
    if (tempIndex != 1) {
      appCubit.onSweetMissed();
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    gameRef.availableSweets.add(imageIndex);
    gameRef.spawnSweets();
  }

  @override
  Future<void> onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BasketFront) {
      isCollidedWithBasket = true;
      audioService.playSound('basket_sound');
      appCubit.addScore(
        tempIndex == 1 ? -200 : 100,
      );
    }
  }
}
