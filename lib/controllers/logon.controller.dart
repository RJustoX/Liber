import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/providers/api.provider.dart';

class LogonController {
  LogonController();

  Future<void> cadastrar(UserModel newUser) async {
    final Map<String, dynamic> data = await ApiProvider().createNewUser(newUser);
    print(data);
    if (data['status'] != 1) throw Exception();
  }
}
