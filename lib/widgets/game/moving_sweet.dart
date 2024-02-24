import 'dart:math';
import 'package:sweetbonanzarain/const/assets.dart';
import 'package:sweetbonanzarain/services/audio_service.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sweetbonanzarain/bloc/app/app_cubit.dart';
import 'package:sweetbonanzarain/services/images_service.dart';
import 'package:sweetbonanzarain/widgets/game/basket_back.dart';
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
  bool movingToCenter = false;
  double centerSpeed = 200;

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

    if (movingToCenter) {
      double centerX =
          gameRef.basketFront.position.x + gameRef.basketFront.size.x / 2;

      if (position.x < centerX) {
        position.x = min(centerX, position.x + centerSpeed * dt);
      } else if (position.x > centerX) {
        position.x = max(centerX, position.x - centerSpeed * dt);
      }

      position.y += verticalSpeed * dt;
    } else {
      position.y += verticalSpeed * dt;
    }

    if (position.y > gameRef.size.y && !isRemoved) {
      if (!isCollidedWithBasket) {
        onFallenOutside();
      }
      removeFromParent();
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

    if ((other is BasketBack) && !movingToCenter) {
      movingToCenter = true;
    }

    if (other is BasketFront) {
      isCollidedWithBasket = true;
      audioService.playSound('basket_sound');
      appCubit.addScore(tempIndex == 1 ? -200 : 100);
    }
  }
}
