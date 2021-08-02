

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart' as ui;

class Crate extends PositionComponent{

  static final _paintRow1 = ui.Paint()..color = ui.Colors.white;
  static final _paintRow2 = ui.Paint()..color = ui.Colors.red;
  static final _paintRow3 = ui.Paint()..color = ui.Colors.purple;
  static final _paintRow4 = ui.Paint()..color = ui.Colors.pink;
  static final _paints = [_paintRow1, _paintRow2, _paintRow3, _paintRow4];
  static final Vector2 createSize = Vector2(100,26);

  final int row;

  Crate(Vector2 position, this.row){
    this.position = position;
    size = createSize;
  }

  @override
  void render(Canvas c){
    super.render(c);
    c.drawRect(size.toRect(), _paints[row ~/2]);
  }
}