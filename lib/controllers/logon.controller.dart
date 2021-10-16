import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/models/vicio.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogonController {
  LogonController();

  late List<dynamic> _vicios;

  Future<void> cadastrar(UserModel newUser) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = await ApiProvider().createNewUser(newUser);
    print(data);
    if (data['status'] != 1) {
      throw Exception();
    } else {
      print(data['dados']['currval']);
      await sharedPreferences.setInt('token', data['dados']['currval']);
    }
  }

  void fetchVicios() async {
    _vicios = await ApiProvider().getAllVicios();
  }

  List<dynamic> getVicios() {
    return _vicios;
  }
}
