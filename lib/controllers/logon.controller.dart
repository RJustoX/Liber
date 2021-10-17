import 'package:nicotine/controllers/main.controller.dart';
import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogonController extends MainController {
  LogonController();

  late List<dynamic> _vicios;
  bool loading = true;

  Future<void> cadastrar(UserModel newUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = await ApiProvider().createNewUser(newUser);
    print(data);
    if (data['status'] != 1) {
      throw Exception();
    } else {
      await sharedPreferences.setInt('token', data['dados']['currval']);
    }
  }

  Future<void> finalizaCadastro(UserModel user, int vicioId) async {
    await ApiProvider().finishLogon(user, vicioId);
  }

  Future<void> fetchVicios() async {
    _vicios = await ApiProvider().getAllVicios();
  }

  List<dynamic> getVicios() {
    return _vicios;
  }
}
