import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_crate/crates_game.dart';

class MiniGames extends StatefulWidget {
  const MiniGames({Key? key}) : super(key: key);

  @override
  _MiniGamesState createState() => _MiniGamesState();
}

class _MiniGamesState extends State<MiniGames> {
  CratesGame? _cratesGame;

  @override
  void initState() {
    initGame();
    super.initState();
  }

  void initGame(){
    _cratesGame = CratesGame();
  }

  @override
  Widget build(BuildContext context) {
    if (_cratesGame == null){
      return const Center(child: Text('Loading game...'),);
    }
    return GameWidget(game: _cratesGame!,);
  }
}
