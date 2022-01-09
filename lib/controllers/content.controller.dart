import 'package:nicotine/models/category.model.dart';
import 'package:nicotine/models/reason.model.dart';
import 'package:nicotine/models/report.model.dart';
import 'package:nicotine/providers/api.provider.dart';

class ContentController {
  late List<dynamic> categories;
  late List<dynamic> reasons;
  late List<dynamic> reports;
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

  Future<void> fetchReports(int vicioId) async {
    Map<String, dynamic> map = await ApiProvider().getVicioReports(vicioId);

    if (map['status'] != 0) {
      reports = map['value'].map((dynamic t) {
        return ReportModel.fromJson(t as Map<String, dynamic>);
      }).toList();
    } else
      message = map['message'];
  }
}
