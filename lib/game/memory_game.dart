import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'game.constants.dart';
import 'game.settings.dart';
import 'game.widgets.dart';
import 'game_controller.dart';
import 'game_model.dart';

class MemoryGame extends StatelessWidget {
  final GamePlay gamePlay;

  const MemoryGame({Key? key, required this.gamePlay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GameScore(modo: gamePlay.modo),
      ),
      // body: const FeedbackGame(resultado: Resultado.eliminado),

      body: Observer(
        builder: (_) {
          if (controller.venceu) {
            return const FeedbackGame(resultado: Resultado.aprovado);
          } else if (controller.perdeu) {
            return const FeedbackGame(resultado: Resultado.eliminado);
          } else {
            return Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: GameSettings.gameBoardAxisCount(gamePlay.nivel),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(24),
                children: controller.gameCards
                    .map(
                      (GameOpcao go) => CardGame(modo: gamePlay.modo, gameOpcao: go),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class FeedbackGame extends StatelessWidget {
  final Resultado resultado;

  const FeedbackGame({Key? key, required this.resultado}) : super(key: key);

  String getResultado() {
    return resultado == Resultado.aprovado ? 'aprovado' : 'eliminado';
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<GameController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${getResultado().toUpperCase()}!',
            style: const TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset('assets/game/${getResultado()}.png'),
          ),
          resultado == Resultado.eliminado
              ? StartButton(
                  title: 'Tentar novamente',
                  color: Colors.white,
                  action: () => controller.restartGame(),
                )
              : StartButton(
                  title: 'Próximo Nível',
                  color: Colors.white,
                  action: () => controller.nextLevel(),
                ),
        ],
      ),
    );
  }
}
