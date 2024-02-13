import 'dart:ui';
import 'package:flame/components.dart';
import 'package:sweetbonanzarain/widgets/game/bonanzo_game.dart';

class Explosion extends SpriteAnimationComponent with HasGameRef<BonanzoGame> {
  Explosion({required Image image, required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(100.0),
          removeOnFinish: true,
          animation: SpriteAnimation.fromFrameData(
            image,
            SpriteAnimationData.sequenced(
              amount: 7,
              stepTime: 0.1,
              textureSize: Vector2(200.0, 200.0),
              amountPerRow: 1,
              loop: false,
            ),
          ),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
