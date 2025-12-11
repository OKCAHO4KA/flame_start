import 'dart:async';

import 'package:flama_game/components/background_image_component.dart';
import 'package:flama_game/components2/boy_component.dart';
import 'package:flama_game/components2/meteor_component.dart';
import 'package:flame/experimental.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame2 extends FlameGame
    with
        // KeyboardEvents, /* TapCallbacks*/
        HasKeyboardHandlerComponents,
        TapCallbacks,
        HasCollisionDetection {
  double elapsedTime = 0.0;

  @override
  FutureOr<void> onLoad() async {
    BackgroundImageComponent background = BackgroundImageComponent();
    background.loaded.then((value) {
      BoyComponent boy = BoyComponent(mapSize: background.size);
      world.add(boy);
      camera.follow(boy);
      camera.setBounds(
        // Rectangle.fromLTRB(0, 0, background.size.x, background.size.y),
        Rectangle.fromLTRB(0, 0, background.size.x, background.size.y),
      );
    });

    world.add(background);

    // add(MeteorCompanent());
    world.add(ScreenHitbox());
    return super.onLoad();
  }

  @override
  update(double dt) {
    if (elapsedTime > 1.0) {
      world.add(MeteorCompanent(cameraPosition: camera.viewfinder.position));
      elapsedTime = 0.0;
    }
    elapsedTime += dt;
    print(camera.viewfinder.position.x);
    print(camera.viewfinder.position.y);
    return super.update(dt);
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

  // @override
  // Color backgroundColor() {
  //   super.backgroundColor();
  //   return Colors.blueGrey;
  // }
}

void main() {
  runApp(GameWidget(game: MyGame2()));
}
