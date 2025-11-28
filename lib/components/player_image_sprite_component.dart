import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerImageSpriteComponent extends SpriteComponent with KeyboardHandler {
  late double screenWidth, screenHeight, centerX, centerY;
  final double spriteWidth = 250, spriteHeight = 250;
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('oso.png');
    final FlutterView view =
        WidgetsBinding.instance.platformDispatcher.views.first;

    screenWidth = MediaQueryData.fromView(view).size.width;
    screenHeight = MediaQueryData.fromView(view).size.height;

    size = Vector2(spriteWidth, spriteHeight);
    centerX = (screenWidth / 2) - (spriteWidth / 2);
    centerY = (screenHeight / 2) - (spriteHeight / 2);

    position = Vector2(centerX, centerY);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // centerX -= 2;
    // centerY += 1;
    position = Vector2(centerX, centerY);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // switch (event.logicalKey.keyLabel) {
    //   case "Arrow Right":
    //     centerX += 5;
    //   case "Arrow Left":
    //     centerX -= 5;
    //   case "Arrow Up":
    //     centerY -= 5;
    //   case "Arrow Down":
    //     centerY += 5;

    //   // break;
    //   default:
    // }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      centerX += 15;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      centerX -= 15;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      centerY -= 15;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      centerY += 35;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
