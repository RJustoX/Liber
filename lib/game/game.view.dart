import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/game/game.settings.dart';
import 'package:nicotine/game/memory_game.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:provider/src/provider.dart';
import 'game.constants.dart';
import 'game.widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'game_controller.dart';
import 'game_model.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);
  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NivelPage(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarComponent(
        context,
        centerTitle: false,
        title: 'Distração',
        haveLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Jogo da memória',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Lute contra a abstinencia se distraindo um pouco e exercitando sua memória!',
                style: TextStyle(
                  color: AppColors.primaryFontColor,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 60.0.h),
                child: Image.asset(
                  'assets/game/memoryGameIcon.png',
                  height: 200.h,
                ),
              ),
              StartButton(
                title: 'Modo Normal',
                color: Colors.white,
                action: () => selecionarNivel(Modo.normal, context),
              ),
              StartButton(
                title: 'Modo Round 6',
                color: Colors.white,
                action: () => selecionarNivel(Modo.round6, context),
              ),
              const SizedBox(height: 60),
              const Recordes(),
            ],
          ),
        ),
      ),
    );
  }
}

class NivelPage extends StatelessWidget {
  final Modo modo;

  const NivelPage({Key? key, required this.modo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final niveis = GameSettings.niveis
        .map((n) => CardNivel(gamePlay: GamePlay(modo: modo, nivel: n)))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nível do Jogo'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          padding: const EdgeInsets.all(24),
          children: niveis,
        ),
      ),
    );
  }
}

class CardNivel extends StatelessWidget {
  final GamePlay gamePlay;

  const CardNivel({Key? key, required this.gamePlay}) : super(key: key);

  startGame(BuildContext context) {
    context.read<GameController>().startGame(gamePlay: gamePlay);

    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => MemoryGame(gamePlay: gamePlay),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => startGame(context),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 90,
        height: 90,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: gamePlay.modo == Modo.normal ? Colors.white : Colors.red,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: gamePlay.modo == Modo.normal ? Colors.transparent : Colors.red.withOpacity(.6),
        ),
        child: Center(
          child: Text(gamePlay.nivel.toString(), style: const TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
