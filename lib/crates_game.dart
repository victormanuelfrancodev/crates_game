
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:game_crate/platform.dart';
import 'package:game_crate/view_state.dart';
import 'ball.dart';
import 'bg.dart';
import 'crate.dart';

class CratesGame extends BaseGame with HasDraggableComponents{

  ViewState viewState = ViewState.gameOver;
  late Platform platform;
  late Ball ball;
  late bool isPause;

  // Called by flame before game-loop begins.
  @override
  Future<void> onLoad() {
    setup();
    return super.onLoad();
  }

  @override
  void update(double dt) {

    super.update(dt);
  }

  void setup(){
    isPause = false;
    add(Bg());
    add(platform = Platform());
    add(ball = Ball());
    createCreates();
  }

  void onLose(){
    isPause = true;
    clear();
    setup();
    camera.shake(amount: 2.0);
    overlays.add('gameOver');
  }

  void createCreates(){
    final grid = Vector2(5,8);
    final margin = Vector2(5,5);

    final unitWidth = Crate.createSize + margin;
    final totalDimensions = grid.clone()..multiply(unitWidth);
    final start = ((size- totalDimensions)/2)..y = 100.0;

    for (var i = 0; i < grid.x; i++){
      for (var j = 0; j < grid.y; j++){
        final p = start + (Vector2Extension.fromInts(i, j)..multiply(unitWidth));
        add(Crate(p,j));
      }
    }
  }

}