import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:sweetbonanzarain/widgets/game/bonanza_game.dart';

class MovingCloudsComponent extends PositionComponent
    with HasGameRef<BonanzaGame> {
  final Sprite cloudSprite;
  final double speed;

  MovingCloudsComponent({required this.cloudSprite, required this.speed});

  @override
  Future<void> onLoad() async {
    size = Vector2(
      gameRef.size.x * 2,
      cloudSprite.image.height *
          ((gameRef.size.x * 1) / cloudSprite.image.width),
    );
    position = Vector2(-size.x / 2, 150);
    anchor = Anchor.topLeft;

    final cloudComponent1 = SpriteComponent(
      sprite: cloudSprite,
      size: Vector2(size.x / 2, size.y),
    );
    final cloudComponent2 = SpriteComponent(
      sprite: cloudSprite,
      size: Vector2(size.x / 2, size.y),
    )..position = Vector2(size.x / 2, 0);

    cloudComponent1.priority = 2;
    cloudComponent2.priority = 2;
    add(cloudComponent1);
    add(cloudComponent2);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += speed * dt;

    priority = 2;
    priority = 2;

    if (position.x >= 0) {
      position.x -= size.x / 2;
    }
  }
}
