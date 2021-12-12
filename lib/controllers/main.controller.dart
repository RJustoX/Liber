import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController {
  MainController(
    UserStore uStore,
  ) {
    _uStore = uStore;
  }
  late UserStore _uStore;
  late UserModel _user;
  bool loading = true;

  Future<void> fetchUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getInt('token'));
    _user = await ApiProvider().getUser(sharedPreferences.getInt('token')!);
    setUser();
  }

  void setUser() {
    _uStore.setUser(_user);
  }
}
