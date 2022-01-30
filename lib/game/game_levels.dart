import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/game/game.constants.dart';
import 'package:nicotine/game/game_model.dart';

import 'game.settings.dart';
import 'game.view.dart';

class GameLevels extends StatelessWidget {
  final Modo modo;

  const GameLevels({Key? key, required this.modo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final niveis = GameSettings.niveis
        .map(
          (n) => CardNivel(
            gamePlay: GamePlay(modo: modo, nivel: n),
          ),
        )
        .toList();

    return Scaffold(
      appBar: DefaultAppBarComponent(
        context,
        title: 'Selecione o nivel',
        centerTitle: true,
        haveLeading: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Image.asset(
              'assets/game/memoryGameIcon.png',
              height: 150,
            ),
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(24),
              children: niveis,
            ),
          ),
        ],
      ),
    );
  }
}
