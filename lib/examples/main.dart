import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

// sprite_components
class MySprite extends SpriteComponent {
  double posOsoX = 0;

  MySprite() : super(size: Vector2.all(300));
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('oso.png');

    return super.onLoad();
  }

  @override
  void update(double dt) {
    posOsoX++;
    position = Vector2(posOsoX, posOsoX);
    super.update(dt);
  }
}

class MyGameOso extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    add(MySprite());
    return super.onLoad();
  }
}

void main() {
  runApp(GameWidget(game: MyGameOso()));
}
