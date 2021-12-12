import 'package:mobx/mobx.dart';
import 'package:nicotine/models/user.model.dart';
part 'user.store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  UserModel? user;

  @action
  void setUser(UserModel pUser) {
    user = pUser;
  }

  @action
  void unsetUser() {
    user = null;
  }
}
