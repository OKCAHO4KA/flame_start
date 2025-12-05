import 'dart:async';
import 'dart:ui';

import 'dart:math';
import 'package:flama_game/utils/create_animation_by_limit.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class MeteorCompanent extends SpriteAnimationComponent with CollisionCallbacks {
  static const int circleSpeed = 250;
  static const double circleWidth = 100.0;
  static const double circleHeight = 100.0;
  static const double spriteSheetWidth = 174.6;
  static const double spriteSheetHeight = 348;
  Random random = Random();
  late double screenWidth, screenHeight; //centerX, centerY;
  double posY = 0.0 - circleHeight;
  final ShapeHitbox hitbox = CircleHitbox();

  @override
  FutureOr<void> onLoad() async {
    final FlutterView view =
        WidgetsBinding.instance.platformDispatcher.views.first;

    screenWidth = MediaQueryData.fromView(view).size.width;
    screenHeight = MediaQueryData.fromView(view).size.height;
    // circleDirectionX = random.nextInt(2) == 1 ? 1 : -1;
    // circleDirectionY = random.nextInt(2) == 1 ? 1 : -1;
    // centerX = (screenWidth / 2) - (circleWidth / 2);
    // centerY = (screenHeight / 2) - (circleHeight / 2);

    // position = Vector2(centerX, centerY);

    position = Vector2(random.nextDouble() * screenWidth, posY);
    // position = Vector2(random.nextDouble() * 500, random.nextDouble() * 500);

    size = Vector2(circleWidth, circleHeight);
    // if (id == 1) {
    hitbox.paint.color = BasicPalette.blue.color;
    //   ;
    // } else if (id == 2) {
    //   hitbox.paint.color = BasicPalette.red.color;
    // } else if (id == 3) {
    //   hitbox.paint.color = BasicPalette.green.color;
    // }
    // hitbox.renderShape = true;

    final spriteMeteor = await Flame.images.load('meteor.png');
    final spriteSheet = SpriteSheet(
      image: spriteMeteor,
      srcSize: Vector2(spriteSheetWidth, spriteSheetHeight),
    );
    animation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 2,
      sizeX: 5,
      stepTime: 0.1,
    );

    add(hitbox);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is ScreenHitbox) {
      //top
      // if (intersectionPoints.first[1] <= 0) {
      //   circleDirectionX = random.nextInt(2) == 1 ? 1 : -1;
      //   circleDirectionY *= -1;
      // }
      //bottom
      // else if (intersectionPoints.first[1] >= screenHeight) {
      //   circleDirectionX = random.nextInt(2) == 1 ? 1 : -1;
      //   circleDirectionY *= -1;
      // circleDirectionX *= -1;
      // circleDirectionY *= -1;
      // }
      //left
      // else if (intersectionPoints.first[0] <= 0) {
      //   circleDirectionX *= -1;
      //   circleDirectionY = random.nextInt(2) == 1 ? 1 : -1;
      // }
      //right
      //   else if (intersectionPoints.first[0] >= screenWidth) {
      //     circleDirectionX *= -1;
      //     circleDirectionY = random.nextInt(2) == 1 ? 1 : -1;
      //   }
      // }
      if (other is MeteorCompanent) {
        // circleDirectionX *= -1;
        // circleDirectionY *= -1;
        //   circleDirectionX = random.nextInt(2) == 1 ? 1 : -1;
        //   circleDirectionY = random.nextInt(2) == 1 ? 1 : -1;
        // hitbox.paint.color = ColorExtension.random();
        // if (id == 2) {
        //   contadorColisiones++;
        // }
      }
      // hitbox.paint.color = ColorExtension.random();
      super.onCollision(intersectionPoints, other);
    }
  }

  @override
  void update(double dt) {
    // position.x += circleDirectionX * circleSpeed * dt;
    position.y += circleSpeed * dt;
    // position.y += circleDirectionY * circleSpeed * dt;
    if (position.y > screenHeight) {
      removeFromParent();
    }
    super.update(dt);
  }
}
