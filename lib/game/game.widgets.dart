import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'game.constants.dart';
import 'game.records.dart';
import 'game_controller.dart';
import 'game_model.dart';

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
      elevation: 0.0,
      color: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Recordes',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 28.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 7.5),
                  Icon(FontAwesomeIcons.trophy)
                ],
              ),
            ),
            ListTile(
              title: const Text('Modo Normal'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.normal),
            ),
            ListTile(
              title: const Text('Modo Desafio'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showRecordes(Modo.desafio),
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
            Icon(modo == Modo.desafio ? Icons.my_location : Icons.touch_app_rounded),
            const SizedBox(width: 10),
            Observer(
                builder: (_) =>
                    Text(controller.score.toString(), style: const TextStyle(fontSize: 25))),
          ],
        ),
        TextButton(
          child: const Text(
            'Sair',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
