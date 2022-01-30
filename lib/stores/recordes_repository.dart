import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:nicotine/game/game.constants.dart';
import 'package:nicotine/game/game_model.dart';
part 'recordes_repository.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;

abstract class RecordesRepositoryBase with Store {
  late final Box _recordes;
  late final GamePlay gamePlay;
  @observable
  Map recordesDesafio = {};
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
    _recordes = await Hive.openBox('gameRecordes3');
  }

  @action
  loadRecordes() {
    recordesNormal = _recordes.get(Modo.normal.toString()) ?? {};
    recordesDesafio = _recordes.get(Modo.desafio.toString()) ?? {};
  }

  updateRecordes({required GamePlay gamePlay, required int score}) {
    final key = gamePlay.modo.toString();

    if (gamePlay.modo == Modo.normal &&
        (recordesNormal[gamePlay.nivel] == null || score < recordesNormal[gamePlay.nivel])) {
      recordesNormal[gamePlay.nivel] = score;
      _recordes.put(key, recordesNormal);
    } else if (gamePlay.modo == Modo.desafio &&
        (recordesDesafio[gamePlay.nivel] == null || score > recordesDesafio[gamePlay.nivel])) {
      recordesDesafio[gamePlay.nivel] = score;
      _recordes.put(key, recordesDesafio);
    }
  }
}
