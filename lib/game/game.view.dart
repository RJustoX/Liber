import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/button/default_primary_button.component.dart';
import 'package:nicotine/game/memory_game.dart';
import 'package:nicotine/utils/app_colors.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'game.constants.dart';
import 'game.widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'game_controller.dart';
import 'game_levels.dart';
import 'game_model.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);
  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameLevels(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                child: Icon(
                  FontAwesomeIcons.gamepad,
                  size: 180.0.h,
                ),
              ),
              DefaultPrimaryButtonComponent(
                onTap: () => selecionarNivel(Modo.normal, context),
                title: 'Modo normal',
                revertColors: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: DefaultPrimaryButtonComponent(
                  onTap: () => selecionarNivel(Modo.desafio, context),
                  title: 'Modo desafio',
                ),
              ),
              const Recordes(),
            ],
          ),
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
        builder: (BuildContext context) => MemoryGame(
          gamePlay: gamePlay,
        ),
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
            color: gamePlay.modo == Modo.normal ? Colors.blue : Colors.red,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: gamePlay.modo == Modo.normal ? Colors.blueAccent[100]! : Colors.red[100],
        ),
        child: Center(
          child: Text(gamePlay.nivel.toString(),
              style: const TextStyle(
                fontSize: 30,
              )),
        ),
      ),
    );
  }
}
