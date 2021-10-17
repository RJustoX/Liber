import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/providers/api.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController {
  MainController();

  late UserModel _user;
  bool loading = true;

  Future<void> fetchUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getInt('token'));
    _user = await ApiProvider().getUser(sharedPreferences.getInt('token')!);
  }

  /// GETTERS ///

  UserModel getUser() => _user;

  DateTime? getUserBirthDate() => _user.birthDate;

  int? getUSerGender() => _user.gender;

  String getUserName() => _user.name;

  /// SETTERS ///

  void setUserBirthDate(DateTime date) {
    _user.birthDate = date;
  }

  void setUSerGender(int gender) {
    _user.gender = gender;
  }
}
