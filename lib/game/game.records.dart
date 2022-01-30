import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/game/game.constants.dart';
import 'package:nicotine/stores/recordes_repository.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:provider/provider.dart';

class GameRecords extends StatefulWidget {
  final Modo modo;

  const GameRecords({
    Key? key,
    required this.modo,
  }) : super(key: key);

  @override
  State<GameRecords> createState() => _GameRecordsState();
}

class _GameRecordsState extends State<GameRecords> {
  getModo() {
    return widget.modo == Modo.normal ? 'Normal' : 'Desafio';
  }

  MainAxisAlignment mainAxis = MainAxisAlignment.start;

  List<Widget> getRecordesList(Map recordes) {
    final List<Widget> widgets = [];

    recordes.forEach((nivel, score) {
      widgets.add(
        ListTile(
          title: Text(
            'Nível $nivel',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Text(
            score.toString(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          tileColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      );

      widgets.add(const Divider(color: Colors.transparent));
    });

    if (widgets.isEmpty) {
      mainAxis = MainAxisAlignment.center;
      widgets.add(
        Center(
          child: Text(
            'Ainda não há recordes neste modo, \n jogue uma partida ${getModo()}!',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<RecordesRepository>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: DefaultAppBarComponent(
        context,
        title: 'Recordes modo ${getModo()}',
        haveLeading: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Observer(
          builder: (context) => Column(
            mainAxisAlignment: mainAxis,
            children: <Widget>[
              ...getRecordesList(
                widget.modo == Modo.normal ? repository.recordesNormal : repository.recordesRound6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
