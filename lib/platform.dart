
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' as ui;
import 'package:flutter/painting.dart';

import 'crates_game.dart';


class Platform extends PositionComponent with HasGameRef<CratesGame>, Draggable{

  final _paintBorderWhite = BasicPalette.white.paint()..color = ui.Colors.blueAccent;
  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    anchor = Anchor.topCenter;
    x= gameRef.size.x / 2;
    y = gameRef.size.y - 100;
    size = Vector2(100,20);
  }

  late Vector2 previousPosition = position;
  Vector2 averageVelocity = Vector2.zero();

  @override
  void render(Canvas canvas){
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paintBorderWhite);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (dt != 0){
      this.averageVelocity = (position - this.previousPosition) / dt;
      this.previousPosition = position.clone();
    }
  }

  double? dragX;

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    if(gameRef.isPause){
      return false;
    }
    x += info.delta.game.x;
    if(gameRef.ball.isReset){
      gameRef.ball.launch();
    }
    return true;
  }

}