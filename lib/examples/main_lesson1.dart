import 'dart:async';

import 'package:flama_game/components/boy_sprite_component.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame
    with
        KeyboardEvents, /* TapCallbacks*/
        HasKeyboardHandlerComponents,
        TapCallbacks,
        HasCollisionDetection {
  @override
  FutureOr<void> onLoad() {
    add(BoySpriteComponent());
    // add(CirclePositionCompanent(id: 1));
    // add(CirclePositionCompanent(id: 2));
    // add(CirclePositionCompanent(id: 3));
    add(ScreenHitbox());
    return super.onLoad();
  }

  // @override
  // KeyEventResult onKeyEvent(
  //   KeyEvent event,
  //   Set<LogicalKeyboardKey> keysPressed,
  // ) {
  //   return super.onKeyEvent(event, keysPressed);
  // }

  //   @override
  //   void onTapDown(TapDownEvent event) {
  //     print(event);

  //     super.onTapDown(event);
  //   }

  //   @override
  //   void onTapUp(TapUpEvent event) {
  //     print(event);
  //     super.onTapUp(event);
  //   }
}

void main() {
  runApp(GameWidget(game: MyGame()));
}
