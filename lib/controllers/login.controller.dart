import 'package:nicotine/models/login.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  LoginController();

  Future<void> login(LoginModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = await ApiProvider().postLogin(model);
    if (data['status'] != 1) throw Exception();
    sharedPreferences.setString('token', data['dados']['id_usuario']);
    print(sharedPreferences.getString('token'));
  }
}
