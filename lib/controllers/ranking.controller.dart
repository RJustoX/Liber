import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/providers/api.provider.dart';

class RankingController {
  late List<UserRankingModel> allTimeUsers;
  late List<UserRankingModel> trinityUsers;
  late String message;
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
}