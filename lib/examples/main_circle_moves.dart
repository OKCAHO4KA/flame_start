import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class MyGame with Game {
  double circlePosXOrange = 10;
  double circlePosXBlue = 600;
  double radiusCircle = 10;
  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(circlePosXOrange, 400),
      radiusCircle,
      BasicPalette.orange.paint(),
    );
    canvas.drawCircle(
      Offset(circlePosXBlue, 400),
      radiusCircle,
      BasicPalette.blue.paint(),
    );
  }

  @override
  void update(double dt) {
    circlePosXOrange++;
    circlePosXBlue--;
    radiusCircle += 0.5;
  }
}

void main() {
  runApp(GameWidget(game: MyGame()));
}
