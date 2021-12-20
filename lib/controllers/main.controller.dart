import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/models/vicio.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController {
  MainController(
    UserStore uStore,
    VicioStore vStore,
  ) {
    _vStore = vStore;
    _uStore = uStore;
  }
  late UserStore _uStore;
  late VicioStore _vStore;
  late UserModel _user;
  late List<dynamic> _vicios;
  bool loading = true;

  Future<void> fetchUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getInt('token'));
    _user = await ApiProvider().getUser(sharedPreferences.getInt('token')!);
    _vicios = await ApiProvider().getUserVicios(_user.id);
    _user.vicios = _vicios.cast<VicioModel>();

    setUser();
    setVicio(sharedPreferences.getInt('vicio') ?? _vicios[0].id);
  }

  VicioModel getCurrentVicio(int vicioId) {
    return _vicios.firstWhere((dynamic vicio) => vicio.id == vicioId);
  }

  void setVicio(int id) {
    _vStore.setVicio(getCurrentVicio(id));
  }

  void setUser() {
    _uStore.setUser(_user);
  }
}
