import 'package:nicotine/models/_index.dart';
import 'package:nicotine/providers/api.provider.dart';

class ContentController {
  late List<dynamic> categories;
  late List<dynamic> reasons;
  late List<dynamic> reports;
  late List<dynamic> tips;
  int? selectedReason;
  int? selectedCategory;
  bool isLoading = true;
  bool filtering = false;
  String? message;

  /// GETS DO BANCO

  Future<void> fetchCategories(int vicioId) async {
    Map<String, dynamic> map = await ApiProvider().getCategories(vicioId);

    if (map['status'] != 0) {
      categories = map['value'].map((dynamic t) {
        return CategoryModel.fromJson(t as Map<String, dynamic>);
      }).toList();
    } else
      message = map['message'];
  }

  Future<void> fetchReasons(int userId, int vicioId) async {
    Map<String, dynamic> map = await ApiProvider().getReasons(vicioId);

    if (map['status'] != 0) {
      reasons = map['value'].map((dynamic t) {
        return ReasonModel.fromJson(t as Map<String, dynamic>);
      }).toList();
    } else
      message = map['message'];
  }

  Future<void> fetchReports(int userId, int vicioId) async {
    Map<String, dynamic> map = await ApiProvider().getVicioReports(userId, vicioId);

    if (map['status'] != 0) {
      reports = map['value'].map((dynamic t) {
            return ReportModel.fromJson(t as Map<String, dynamic>);
          }).toList() ??
          [];
      reports.shuffle();
    } else {
      message = map['message'];
      reports = [];
    }
  }

  Future<void> fetchTips(
    int userId,
    int vicioId, {
    int? categoryId,
  }) async {
    Map<String, dynamic> map = await ApiProvider().getVicioTips(userId, vicioId);

    if (map['status'] != 0) {
      tips = map['value'].map((dynamic t) {
        return TipModel.fromJson(t as Map<String, dynamic>);
      }).toList();

      tips.shuffle();
    } else {
      message = map['message'];
      tips = [];
    }
  }

  /// FILTRAR DICAS

  CategoryModel getCategory(int id) {
    return categories.firstWhere((dynamic category) => category.id == id);
  }

  List<dynamic> getFilterTips(List<dynamic> list) {
    List<dynamic> result = [];
    if (selectedCategory != null) {
      result = list.where((dynamic d) => d.idCategory == selectedCategory).toList();
      result.shuffle();
    } else {
      result = list;
    }

    return result;
  }

  void setCategoryFilter(CategoryModel tip) {
    for (dynamic r in categories) {
      if (r.id == tip.id) {
        selectedCategory = selectedCategory != tip.id ? tip.id : null;
        tip.selected = !tip.selected;
      } else
        r.selected = false;
    }
  }

  /// FILTRAR RELATOS

  ReasonModel getReason(int id) {
    return reasons.firstWhere((dynamic reason) => reason.id == id);
  }

  List<dynamic> getFilterReports(List<dynamic> list) {
    List<dynamic> result = [];
    if (selectedReason != null) {
      result = list.where((dynamic d) => d.idReason == selectedReason).toList();
      result.shuffle();
    } else {
      result = list;
    }

    return result;
  }

  void setReasonFilter(ReasonModel reason) {
    for (dynamic r in reasons) {
      if (r.id == reason.id) {
        selectedReason = selectedReason != reason.id ? reason.id : null;
        reason.selected = !reason.selected;
      } else
        r.selected = false;
    }
  }

  void likeContent(dynamic content, bool add) async {
    Map<String, dynamic> map = await ApiProvider().likeContent(content, add);
    if (map['status'] == 0) {
      message = map['message'];
    }
  }

  Future<String> deleteContent(int id) async {
    Map<String, dynamic> map = await ApiProvider().deleteContent(id);
    return map['message'];
  }
}
