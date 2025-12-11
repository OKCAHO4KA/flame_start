import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Background extends PositionComponent {
  late double screenWidth, screenHeight;
  static final backgroundColorPaint = BasicPalette.white.paint();
  @override
  FutureOr<void> onLoad() {
    final FlutterView view =
        WidgetsBinding.instance.platformDispatcher.views.first;

    screenWidth = MediaQueryData.fromView(view).size.width;
    screenHeight = MediaQueryData.fromView(view).size.height;

    position = Vector2(0, 0);
    size = Vector2(screenWidth, screenHeight);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromPoints(position.toOffset(), size.toOffset()),
      backgroundColorPaint,
    );
    super.render(canvas);
  }
}
