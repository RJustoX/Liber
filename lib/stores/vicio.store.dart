import 'package:mobx/mobx.dart';
import 'package:nicotine/models/vicio.model.dart';
part 'vicio.store.g.dart';

class VicioStore = _VicioStore with _$VicioStore;

abstract class _VicioStore with Store {
  @observable
  VicioModel? vicio;

  @action
  void setVicio(VicioModel pVicio) {
    vicio = pVicio;
  }

  @action
  void unsetVicio() {
    vicio = null;
  }
}
