import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Character extends SpriteAnimationComponent
    with TapCallbacks, KeyboardHandler, CollisionCallbacks {
  late double screenWidth, screenHeight, centerX, centerY;

  final double spriteSheetWidth = 260, spriteSheetHeight = 400;

  bool right = true;

  bool colisionXRight = false, colisionXLeft = false;

  int posX = 0, posY = 0;

  double playerSpeed = 500;

  double gravity = 1.8;

  Vector2 velocity = Vector2(0, 0);

  final double jumpForce = 130;

  bool inGround = true;

  // final ShapeHitbox hitbox = CircleHitbox();

  late SpriteAnimation walkAnimation,
      jumpAnimation,
      deadAnimation,
      idleAnimation,
      walkSlowAnimation,
      runAnimation;
}
