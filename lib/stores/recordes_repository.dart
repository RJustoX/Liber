import 'package:mobx/mobx.dart';
import 'package:nicotine/game/game.constants.dart';
import 'package:nicotine/game/game_model.dart';
part 'recordes_repository.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;

abstract class RecordesRepositoryBase with Store {
  //late final Box _recordes;
  late final GamePlay gamePlay;
  @observable
  Map recordesRound6 = {};
  @observable
  Map recordesNormal = {};

  RecordesRepositoryBase() {
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await loadRecordes();
  }

  _initDatabase() async {
    //  _recordes = await Hive.openBox('gameRecordes3');
  }

  @action
  loadRecordes() {
    // recordesNormal = _recordes.get(Modo.normal.toString()) ?? {};
    // recordesRound6 = _recordes.get(Modo.round6.toString()) ?? {};
  }

  updateRecordes({required GamePlay gamePlay, required int score}) {
    final key = gamePlay.modo.toString();

    if (gamePlay.modo == Modo.normal &&
        (recordesNormal[gamePlay.nivel] == null || score < recordesNormal[gamePlay.nivel])) {
      recordesNormal[gamePlay.nivel] = score;
      // _recordes.put(key, recordesNormal);
    } else if (gamePlay.modo == Modo.desafio &&
        (recordesRound6[gamePlay.nivel] == null || score > recordesRound6[gamePlay.nivel])) {
      recordesRound6[gamePlay.nivel] = score;
      //  _recordes.put(key, recordesRound6);
    }
  }
}
