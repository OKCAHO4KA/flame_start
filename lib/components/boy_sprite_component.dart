import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoySpriteComponent extends SpriteAnimationComponent
    with TapCallbacks, KeyboardHandler, CollisionCallbacks {
  late double screenWidth, screenHeight, centerX, centerY;
  final double spriteSheetWidth = 260, spriteSheetHeight = 400;
  int indexAnimation = 0;
  bool right = true;
  // final ShapeHitbox hitbox = CircleHitbox();
  late SpriteAnimation boyWalkAnimation,
      boyJumpAnimation,
      boyDeadAnimation,
      boyIdleAnimation,
      boyRunAnimation;

  int posX = 0, posY = 0;
  double playerdSpeed = 500;

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    // sprite = await Sprite.load('.png');
    final spriteBoy = await Flame.images.load('new_sprite.png');
    final spriteSheet = SpriteSheet(
      image: spriteBoy,
      srcSize: Vector2(spriteSheetWidth, spriteSheetHeight),
    );
    boyWalkAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 5,
      sizeX: 7,
      stepTime: 0.1,
    );

    boyJumpAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 2,
      step: 6,
      sizeX: 7,
      stepTime: 0.3,
    );
    boyDeadAnimation = spriteSheet.createAnimationByLimit(
      xInit: 2,
      yInit: 1,
      step: 3,
      sizeX: 7,
      loop: false,
      stepTime: 0.1,
    );
    boyRunAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 6,
      step: 4,
      sizeX: 7,
      stepTime: 0.1,
    );
    boyIdleAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 2,
      step: 1,
      sizeX: 7,
      loop: false,
      stepTime: 0.1,
    );
    animation = boyIdleAnimation;
    // animation = spriteSheet.createAnimationByLimit(
    //   xInit: 0,
    //   yInit: 0,
    //   step: 5,
    //   sizeX: 7,
    //   stepTime: 0.9,
    // );

    // SpriteAnimation.spriteList(sprites, stepTime: stepTime)
    // sprite = spriteSheet.getSprite(1, 6);

    final FlutterView view =
        WidgetsBinding.instance.platformDispatcher.views.first;

    screenWidth = MediaQueryData.fromView(view).size.width;
    screenHeight = MediaQueryData.fromView(view).size.height;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    centerX = (screenWidth / 2) - (spriteSheetWidth / 2);
    centerY = (screenHeight / 2) - (spriteSheetHeight / 2);

    position = Vector2(centerX, centerY);
    debugMode = true;
    add(
      RectangleHitbox(
        position: Vector2(80, 0),
        size: Vector2(spriteSheetWidth - 130, spriteSheetHeight),
      ),
    );
    return super.onLoad();
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   indexAnimation++;
  //   if (indexAnimation == 0) {
  //     animation = boyWalkAnimation;
  //   } else if (indexAnimation == 1) {
  //     animation = boyRunAnimation;
  //   } else if (indexAnimation == 2) {
  //     animation = boyJumpAnimation;
  //   } else if (indexAnimation == 3) {
  //     animation = boyDeadAnimation;
  //     indexAnimation = -1;
  //   }

  //   super.onTapDown(event);
  // }

  // @override
  // void onTapUp(TapUpEvent event) {
  //   super.onTapUp(event);
  // }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isEmpty) {
      animation = boyIdleAnimation;
    }
    if ((keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
            keysPressed.contains(LogicalKeyboardKey.keyD)) &&
        keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
      // centerX++;
      posX++;
      if (!right) {
        flipHorizontally();
        right = true;
      }
      animation = boyRunAnimation;
      playerdSpeed = 1500;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      // centerX--;
      posX++;
      if (!right) {
        flipHorizontally();
        right = true;
      }
      animation = boyWalkAnimation;
      playerdSpeed = 500;
    }

    if ((keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
            keysPressed.contains(LogicalKeyboardKey.keyA)) &&
        keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
      // centerX++;
      posX--;
      if (right) {
        flipHorizontally();
        right = false;
      }
      animation = boyRunAnimation;
      playerdSpeed = 1500;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      // centerX--;
      posX--;
      if (right) {
        flipHorizontally();
        right = false;
      }
      animation = boyWalkAnimation;
      playerdSpeed = 500;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      // centerY -= 15;
      posY--;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      // centerY += 35;
      posY++;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    // centerX -= 2;
    // centerY += 1;
    position.x += playerdSpeed * dt * posX;
    position.y += playerdSpeed * dt * posY;
    posX = 0;
    posY = 0;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print("222");
    super.onCollision(intersectionPoints, other);
  }
}

extension CteateAnimationByLimit on SpriteSheet {
  SpriteAnimation createAnimationByLimit({
    required int xInit,
    required int yInit,
    required int step,
    required int sizeX,
    required double stepTime,
    bool loop = true,
  }) {
    final spriteList = <Sprite>[];
    int x = xInit;
    int y = yInit - 1;
    for (int i = 0; i <= step; i++) {
      if (y >= sizeX) {
        y = 0;
        x++;
      } else {
        y++;
      }

      spriteList.add(getSprite(x, y));
    }
    return SpriteAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}
