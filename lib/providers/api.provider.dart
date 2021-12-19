import 'dart:convert';

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
    Response response = await _dio.post(
        '${url}Inserir&ds_email=${user.email}&ds_senha=${user.senha}&nm_usuario=${user.name}&ds_nickname=${user.nickname}');

    return jsonDecode(response.data);
  }

  Future<void> finishLogon(UserModel user, int idvicio) async {
    await _dio.put(
        '${url}FinalizarCadastro&dt_nascimento=${user.birthDate}&fl_sexo=${user.gender}&id_usuario=${user.id}&id_vicio=$idvicio');
  }

  Future<void> changeUserAvatar(int id, String newAvatar) async {
    await _dio.put('${url}Alterar&id_usuario=$id&nm_avatar=$newAvatar');
  }

  // funcionando
  Future<UserModel> getUser(int id) async {
    final Response response = await _dio.get('$url/user/$id');

    return UserModel.fromJson(response.data);
  }

  Future<List<dynamic>> getAllVicios() async {
    final Response response = await _dio.get('${url}ListarTodosVicios');
    var obj = json.decode(response.data)['dados'];

    return obj.map((dynamic t) {
      return VicioModel.fromJson(t as Map<String, dynamic>);
    }).toList();
  }
}
