
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'crates_game.dart';

class Bg extends Component with HasGameRef<CratesGame>{
  final _paintBorder = BasicPalette.white.paint()..style = PaintingStyle.stroke;

  void render(Canvas c){
    c.drawRect(gameRef.size.toRect().deflate(1.0), _paintBorder);
  }

  @override
  set isHud(bool _isHud) {
    super.isHud = _isHud;
  }

  @override
  int get priority => -1;
}