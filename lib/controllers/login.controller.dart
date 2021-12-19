import 'package:nicotine/models/login.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  LoginController();

  Future<void> login(LoginModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(model.email);
    final int id = await ApiProvider().postLogin(model);
    if (id == 0) {
      throw Exception();
    }
    print(id);
    await sharedPreferences.setInt('token', id);
  }
}
