
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' as ui;
import 'package:game_crate/crates_game.dart';

import 'crate.dart';

class Ball extends PositionComponent with HasGameRef<CratesGame>{

  static const radius = 10.0;
  static const speed = 500.0;

  late bool isReset;
  late Vector2 velocity;
  final _paintWhite = BasicPalette.white.paint()..color = ui.Colors.white;

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    anchor = Anchor.center;
    position = gameRef.platform.position - Vector2(0,Ball.radius);
    velocity = Vector2.zero();
    isReset = true;
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);
    canvas.drawCircle(Offset.zero, radius, _paintWhite);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    final ds = velocity * dt;
    position += ds;

    if(position.x < 0){
      position.x = 0;
      velocity.multiply(Vector2(-1,1));
      gameRef.camera.shake(amount: 0.15);
    }
    else if(position.x> gameRef.size.x){
      position.x = gameRef.size.x;
      velocity.multiply(Vector2(-1,1));
      gameRef.camera.shake(amount: 0.15);
    }
    else if(position.y <  0){
      position.y = 0;
      velocity.multiply(Vector2(1,-1));
      gameRef.camera.shake(amount: 0.15);
    }else if(position.y > gameRef.size.y){
      gameRef.onLose();
    }else{
      final previusRect = (position - ds) & size;
      final effectiveCollisionBounds = toRect().expandToInclude(previusRect);
      final intersects = gameRef.platform.toRect().intersect(effectiveCollisionBounds);
      if(!intersects.isEmpty){
        position.y = gameRef.platform.position.y - Ball.radius;
        velocity.multiply(Vector2(1,-1));
        velocity += gameRef.platform.averageVelocity / 10;
      }else{
        final boxes = gameRef.components.whereType<Crate>();
        var firstBox = true;
        for (final box in boxes){
          final collision = box.toRect().intersect(effectiveCollisionBounds);
          if(!collision.isEmpty){
            if(firstBox){
              velocity.multiply(Vector2(1,-1));
              firstBox = false;
            }
            box.remove();
          }
        }

      }
    }
  }

  void launch(){
    velocity = Vector2(0.75, -1) * Ball.speed;
    isReset = false;
  }


}