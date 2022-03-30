import 'package:dio/dio.dart';
import 'package:nicotine/models/_index.dart';
import 'package:nicotine/models/new_content.model.dart';
import 'package:nicotine/utils/endpoint.dart';

class ApiProvider {
  factory ApiProvider() {
    return _instance;
  }

  ApiProvider._internal();

  static final ApiProvider _instance = ApiProvider._internal();

  final Dio _dio = Dio();
  String url = '${Endpoint.endpointUrl}';

  Future<int> postLogin(LoginModel model) async {
    Response? response = await _dio.post(
      '$url/login',
      data: <String, dynamic>{
        'email': model.email,
        'password': model.password,
      },
    );

    return response.data != null ? response.data : 0;
  }

  Future<Map<String, dynamic>> createNewUser(UserModel user) async {
    Response response = await _dio.post('$url/logon', data: <String, dynamic>{
      'name': user.name,
      'email': user.email,
      'nickname': user.nickname,
      'password': user.senha,
    });

    return response.data;
  }

  Future<void> finishLogon(UserModel user, int idvicio) async {
    await _dio.put('$url/finishLogon', data: <String, dynamic>{
      'id': user.id,
      'birthDate': user.birthDate!.toIso8601String(),
      'sex': user.gender,
      'vicioId': idvicio,
    });
  }

  Future<void> changeUserAvatar(int id, String newAvatar) async {
    await _dio.put('$url/changeAvatar', data: <String, dynamic>{
      'id': id,
      'avatar': newAvatar,
    });
  }

  Future<Map<String, dynamic>> updateUserData(UserModel user) async {
    Response response = await _dio.put(
      '$url/updateUser',
      data: user.toJson(),
    );

    return response.data;
  }

  Future<UserModel> getUser(int id) async {
    final Response response = await _dio.get('$url/user/$id');

    print(response.data);
    return UserModel.fromJson(response.data);
  }

  Future<List<dynamic>> getUserVicios(int userId) async {
    final Response response = await _dio.get('$url/vicios/$userId');

    return response.data['values'].map((dynamic t) {
      return VicioModel.fromJson(t as Map<String, dynamic>);
    }).toList();
  }

  Future<List<dynamic>> getVicio(int userId) async {
    final Response response = await _dio.get('$url/vicios/$userId');

    return response.data['values'].map((dynamic t) {
      return VicioModel.fromJson(t as Map<String, dynamic>);
    }).toList();
  }

  Future<List<dynamic>> getAllVicios() async {
    final Response response = await _dio.get('$url/vicios');

    return response.data.map((dynamic t) {
      return VicioModel.fromJson(t as Map<String, dynamic>);
    }).toList();
  }

  Future<Map<String, dynamic>> setNewVicio(int userId, int vicioId) async {
    final Response response = await _dio.post('$url/insertNewVicio', data: <String, dynamic>{
      'vicioId': vicioId,
      'userId': userId,
    });

    return response.data;
  }

  /// METAS

  Future<Map<String, dynamic>> getUserGoals(int userId) async {
    final Response response = await _dio.get('$url/goals/$userId');

    return response.data;
  }

  Future<Map<String, dynamic>> insertNewGoal(GoalModel goal) async {
    final Response response = await _dio.put(
      '$url/newGoal',
      data: goal.toJson(),
    );
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> deleteGoal(int goalId) async {
    final Response response = await _dio.get('$url/deleteGoal/$goalId');

    return response.data;
  }

  Future<Map<String, dynamic>> updateGoal(GoalModel goal) async {
    final Response response = await _dio.put(
      '$url/editGoal',
      data: goal.toJson(),
    );

    return response.data;
  }

  /// RANKING

  Future<Map<String, dynamic>> getAllTimeRanking(int vicioId) async {
    final Response response = await _dio.get('$url/ranking/allTime/$vicioId');

    return response.data;
  }

  Future<Map<String, dynamic>> getUserPosition(int vicioId, int userId) async {
    final Response response = await _dio.post('$url/ranking/userPosition', data: <String, dynamic>{
      'vicioId': vicioId,
      'userId': userId,
    });

    return response.data;
  }

  /// CONTEÚDOS

  Future<Map<String, dynamic>> getCategories(int vicioId) async {
    final Response response = await _dio.get('$url/vicioCategories/$vicioId');

    return response.data;
  }

  Future<Map<String, dynamic>> getReasons(int vicioId) async {
    final Response response = await _dio.get('$url/vicioReasons/$vicioId');

    return response.data;
  }

  Future<Map<String, dynamic>> getVicioReports(int userId, int vicioId) async {
    final Response response = await _dio.get(
      '$url/getVicioReports/$vicioId',
      options: Options(
        headers: <String, dynamic>{
          'userId': userId,
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getVicioTips(int userId, int vicioId) async {
    final Response response = await _dio.get(
      '$url/getVicioTips/$vicioId',
      options: Options(
        headers: <String, dynamic>{
          'userId': userId,
        },
      ),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> insertNewReport(NewContentModel report) async {
    final Response response = await _dio.put(
      '$url/newReport',
      data: report.toJson(),
    );
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> insertNewTip(NewContentModel tip) async {
    final Response response = await _dio.put(
      '$url/newTip',
      data: tip.toJson(),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> likeContent(dynamic content, bool add) async {
    final Response response = await _dio.put(
      '$url/like',
      data: <String, dynamic>{
        'content': content,
        'add': add,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> deleteContent(int id) async {
    final Response response = await _dio.delete(
      '$url/deleteContent/$id',
    );

    return response.data;
  }

  Future<Map<String, dynamic>> getVicioDiseases(int vicioId) async {
    final Response response = await _dio.get(
      '$url/getDoencas/$vicioId',
    );

    return response.data;
  }
}
