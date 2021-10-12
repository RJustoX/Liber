import 'package:nicotine/models/login.model.dart';
import 'package:nicotine/providers/api.provider.dart';

class LoginController {
  LoginController();

  Future<void> login(LoginModel model) async {
    final Map<String, dynamic> data = await ApiProvider().postLogin(model);
    print(data);
    if (data['status'] != 1) throw Exception();
  }
}
