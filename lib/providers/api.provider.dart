import 'package:dio/dio.dart';
import 'package:nicotine/models/login.model.dart';
import 'package:nicotine/models/user.model.dart';
import 'package:nicotine/models/vicio.model.dart';
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
}
