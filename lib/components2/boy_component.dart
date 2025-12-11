// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flama_game/components2/character.dart';
import 'package:flama_game/components2/meteor_component.dart';
import 'package:flama_game/utils/create_animation_by_limit.dart';

class BoyComponent extends Character {
  Vector2 mapSize;
  BoyComponent({required this.mapSize}) : super() {
    anchor = Anchor.center;
    debugMode = true;
  }
  int count = 0;
  @override
  FutureOr<void> onLoad() async {
    // sprite = await Sprite.load('.png');
    final spriteBoy = await Flame.images.load('new_sprite.png');
    final spriteSheet = SpriteSheet(
      image: spriteBoy,
      srcSize: Vector2(spriteSheetWidth, spriteSheetHeight),
    );
    walkAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 5,
      sizeX: 8,
      stepTime: 0.1,
    );

    jumpAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 3,
      step: 5,
      sizeX: 8,
      stepTime: 0.3,
    );
    deadAnimation = spriteSheet.createAnimationByLimit(
      xInit: 2,
      yInit: 1,
      step: 3,
      sizeX: 8,
      loop: false,
      stepTime: 0.1,
    );
    runAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 5,
      step: 4,
      sizeX: 8,
      stepTime: 0.1,
    );
    idleAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 3,
      step: 0,
      sizeX: 7,
      loop: false,
      stepTime: 0.1,
    );
    walkSlowAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 5,
      sizeX: 7,
      stepTime: 0.2,
    );
    animation = idleAnimation;
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

    size = Vector2(spriteSheetWidth / 2, spriteSheetHeight / 2);
    centerX = (screenWidth / 2) - (spriteSheetWidth / 2);
    centerY = (screenHeight / 2) - (spriteSheetHeight / 2);

    position = Vector2(centerX, centerY);

    add(
      RectangleHitbox(
        position: Vector2(40, 0),
        size: Vector2((spriteSheetWidth - 130) / 2, spriteSheetHeight / 2),
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
      animation = idleAnimation;
    }
    if ((keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
            keysPressed.contains(LogicalKeyboardKey.keyD)) &&
        keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
      // centerX++;
      if (!colisionXRight) {
        posX++;
        animation = runAnimation;
      } else {
        animation = walkSlowAnimation;
      }
      if (!right) {
        flipHorizontally();
        right = true;
      }

      playerSpeed = 1500;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      // centerX--;
      if (!colisionXRight) {
        posX++;
        animation = walkAnimation;
      } else {
        animation = walkSlowAnimation;
      }
      if (!right) {
        flipHorizontally();
        right = true;
      }

      playerSpeed = 500;
    }

    if ((keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
            keysPressed.contains(LogicalKeyboardKey.keyA)) &&
        keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
      // centerX++;
      if (!colisionXLeft) {
        posX--;
        animation = runAnimation;
      } else {
        animation = walkSlowAnimation;
      }
      if (right) {
        flipHorizontally();
        right = false;
      }

      playerSpeed = 1500;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      // centerX--;
      if (!colisionXLeft) {
        posX--;
        animation = walkAnimation;
      } else {
        animation = walkSlowAnimation;
      }
      if (right) {
        flipHorizontally();
        right = false;
      }

      playerSpeed = 500;
    } else if ((keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
            keysPressed.contains(LogicalKeyboardKey.keyW)) &&
        inGround) {
      // centerY -= 15;
      velocity.y = -jumpForce;
      position.y -= 15;
      animation = jumpAnimation;
    }
    // else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
    //     keysPressed.contains(LogicalKeyboardKey.keyS)) {
    //   // centerY += 35;
    //   posY++;
    // }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    // centerX -= 2;
    // centerY += 1;
    position.x += playerSpeed * dt * posX;
    position.y += playerSpeed * dt * posY;
    posX = 0;
    posY = 0;

    if (position.y < mapSize.y - size[1]) {
      velocity.y += gravity;
      position.y += dt * velocity.y;
      inGround = false;
    } else {
      inGround = true;
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ScreenHitbox) {
      if (intersectionPoints.first[0] <= 0.0) {
        colisionXLeft = true;
      } else if (intersectionPoints.first[0] >= (mapSize.x - centerX)) {
        colisionXRight = true;
      }
    }

    if (other is MeteorCompanent) {
      count++;
      other.debugMode = true;
      other.hitbox.removeFromParent();
      other.removeFromParent();
      print('Colisiones con meteoritos: $count');
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    colisionXLeft = colisionXRight = false;
    super.onCollisionEnd(other);
  }
}
