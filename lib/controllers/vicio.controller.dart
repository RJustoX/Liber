import 'package:nicotine/models/vicio.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';

class VicioController {
  VicioController(UserStore uStore) {
    _uStore = uStore;
  }

  late UserStore _uStore;
  late List<VicioModel> _myVicios;
  List<VicioModel>? _vicios;
  bool isLoading = true;

  Future<void> fetchVicios() async {
    _vicios = (await ApiProvider().getAllVicios()).cast<VicioModel>();
    _myVicios = _uStore.user!.vicios!;
    for (VicioModel vicio in _myVicios) {
      _vicios?.removeWhere((VicioModel _vicio) => _vicio.id == vicio.id);
    }
  }

  Future<String> setNewVicio(int vicioId) async {
    Map<String, dynamic> result = await ApiProvider().setNewVicio(_uStore.user!.id, vicioId);
    return result['message'];
  }

  List<VicioModel> getMyVicios() => _myVicios;

  List<VicioModel>? getOtherVicios() => _vicios;
}
