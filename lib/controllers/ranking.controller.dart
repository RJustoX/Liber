import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/providers/api.provider.dart';

class RankingController {
  late List<UserRankingModel> allTimeUsers;
  late List<UserRankingModel> trinityUsers;
  late String message;
  late UserRankingModel userPosition;
  bool isLoading = true;

  Future<void> fetchAllTime(int vicioId) async {
    Map<String, dynamic> response = await ApiProvider().getAllTimeRanking(vicioId);
    message = response['message'];
    print(message);
    if (response['status'] != 0) {
      allTimeUsers = response['values']
          .map((dynamic t) {
            return UserRankingModel.fromJson(t as Map<String, dynamic>);
          })
          .toList()
          .cast<UserRankingModel>();
    }

    trinityUsers = allTimeUsers.getRange(0, 3).toList();
    allTimeUsers.removeRange(0, 3);
  }

  Future<void> fetchUserPosition(int vicioId, UserModel user) async {
    Map<String, dynamic> response = await ApiProvider().getUserPosition(vicioId, user.id);
    message = response['message'];
    print(message);
    if (response['status'] != 0) {
      userPosition = UserRankingModel.fromJson(response['value']);
      userPosition.avatar = user.avatar;
      userPosition.nickname = user.nickname;
    }
  }
}
