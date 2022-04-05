import 'package:nicotine/models/_index.dart';
import 'package:nicotine/providers/api.provider.dart';

class NewContentController {
  late List<dynamic> categories;
  late List<dynamic> reasons;
  late List<dynamic> reports;
  late List<dynamic> tips;
  bool isLoading = true;
  String? message;

  Future<void> fetchCategories(int vicioId) async {
    Map<String, dynamic> map = await ApiProvider().getCategories(vicioId);

    if (map['status'] != 0) {
      categories = map['value'].map((dynamic t) {
        return CategoryModel.fromJson(t as Map<String, dynamic>);
      }).toList();
    } else
      message = map['message'];
  }

  Future<void> fetchReasons(int vicioId) async {
    Map<String, dynamic> map = await ApiProvider().getReasons(vicioId);

    if (map['status'] != 0) {
      reasons = map['value'].map((dynamic t) {
        return ReasonModel.fromJson(t as Map<String, dynamic>);
      }).toList();
    } else
      message = map['message'];
  }

  Map<int, dynamic> getReasonsMap() {
    return <int, dynamic>{
      for (ReasonModel reason in reasons) reason.id!: reason.name,
    };
  }

  Map<int, dynamic> getCategoriesMap() {
    return <int, dynamic>{
      for (CategoryModel category in categories) category.id!: category.name,
    };
  }

  String getReasonImage(int id) {
    return reasons.firstWhere((dynamic reason) => reason.id == id).logo;
  }

  CategoryModel? getCategory(int id) {
    return categories.firstWhere(
      (dynamic category) => category.id == id,
      orElse: () => null,
    );
  }
}
