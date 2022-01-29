import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'game.constants.dart';
import 'game.records.dart';
import 'game_controller.dart';
import 'game_model.dart';

class StartButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function action;

  const StartButton({
    Key? key,
    required this.title,
    required this.color,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: OutlinedButton(
        onPressed: () => action(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class Recordes extends StatefulWidget {
  const Recordes({Key? key}) : super(key: key);

  @override
  State<Recordes> createState() => _RecordesState();
}

class _RecordesState extends State<Recordes> {
  showRecordes(Modo modo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GameRecords(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Recordes',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                ),
              ),
            ),
            ListTile(
              title: const Text('Modo Normal'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.normal),
            ),
            ListTile(
              title: const Text('Modo Round 6'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.round6),
            )
          ],
        ),
      ),
    );
  }
}

class CardGame extends StatefulWidget {
  final Modo modo;
  final GameOpcao gameOpcao;

  const CardGame({
    Key? key,
    required this.modo,
    required this.gameOpcao,
  }) : super(key: key);

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  AssetImage getImage(double angulo) {
    if (angulo > 0.5 * pi) {
      return AssetImage('assets/game/${widget.gameOpcao.opcao.toString()}.png');
    } else {
      return widget.modo == Modo.normal
          ? const AssetImage('assets/game/card_normal.png')
          : const AssetImage('assets/game/card_round.png');
    }
  }

  flipCard() {
    final game = context.read<GameController>();

    if (!animation.isAnimating &&
        !widget.gameOpcao.matched &&
        !widget.gameOpcao.selected &&
        !game.jogadaCompleta) {
      animation.forward();
      game.escolher(widget.gameOpcao, resetCard);
    }
  }

  resetCard() {
    animation.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, _) {
        final angulo = animation.value * pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(angulo);

        return GestureDetector(
          onTap: () => flipCard(),
          child: Transform(
            transform: transform,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.modo == Modo.normal ? Colors.white : Colors.red,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: getImage(angulo),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GameScore extends StatelessWidget {
  final Modo modo;
  const GameScore({Key? key, required this.modo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameController>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(modo == Modo.round6 ? Icons.my_location : Icons.touch_app_rounded),
            const SizedBox(width: 10),
            Observer(
                builder: (_) =>
                    Text(controller.score.toString(), style: const TextStyle(fontSize: 25))),
          ],
        ),
        Image.asset('assets/game/host.png', width: 38, height: 60),
        TextButton(
          child: const Text('Sair', style: TextStyle(fontSize: 18)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
