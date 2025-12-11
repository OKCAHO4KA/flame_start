import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackgroundImageComponent extends SpriteComponent {
  late double screenWidth, screenHeight;
  @override
  FutureOr<void> onLoad() async {
    final FlutterView view =
        WidgetsBinding.instance.platformDispatcher.views.first;

    screenWidth = MediaQueryData.fromView(view).size.width;
    screenHeight = MediaQueryData.fromView(view).size.height;

    position = Vector2(0, 0);
    sprite = await Sprite.load("bg.jpg");
    size = sprite!.originalSize;
    // size = Vector2(screenWidth, screenHeight);

    return super.onLoad();
  }

  // @override
  // void render(Canvas canvas) {
  //   canvas.drawRect(
  //     Rect.fromPoints(position.toOffset(), size.toOffset()),
  //     backgroundColorPaint,
  //   );
  //   super.render(canvas);
  // }
}
