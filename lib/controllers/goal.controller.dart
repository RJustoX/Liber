import 'package:nicotine/models/goal.model.dart';
import 'package:nicotine/providers/api.provider.dart';

class GoalController {
  bool isLoading = true;
  List<dynamic>? goals;
  late String message;

  Future<void> fetchGoals(int userId) async {
    Map<String, dynamic> map = await ApiProvider().getUserGoals(userId);
    message = map['message'];
    if (map['status'] != 0) {
      goals = map['value'].map((dynamic t) {
        return GoalModel.fromJson(t as Map<String, dynamic>);
      }).toList();
    }
  }

  Future<void> deleteGoal(goalId) async {
    Map<String, dynamic> map = await ApiProvider().deleteGoal(goalId);
    message = map['message'];
  }
}
