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
  String url = '${Endpoint.apiUrl}/CrudUsuario.php?oper=';

  Future<Map<String, dynamic>> postLogin(LoginModel model) async {
    Response? response = await _dio.post(
      '${url}Login&ds_email=${model.email}&ds_senha=${model.password}',
    );

    return response.data != null ? jsonDecode(response.data) : <String, dynamic>{};
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

  Future<UserModel> getUser(int id) async {
    final Response response = await _dio.get('${url}Consultar&id_usuario=$id');

    return UserModel.fromJson(jsonDecode(response.data)['dados']);
  }

  Future<List<dynamic>> getAllVicios() async {
    final Response response = await _dio.get('${url}ListarTodosVicios');
    var obj = json.decode(response.data)['dados'];

    return obj.map((dynamic t) {
      return VicioModel.fromJson(t as Map<String, dynamic>);
    }).toList();
  }
}
