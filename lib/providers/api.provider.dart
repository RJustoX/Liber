import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nicotine/models/login.model.dart';
import 'package:nicotine/models/user.model.dart';
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
    print(response.data);
    return response.data != null ? jsonDecode(response.data) : <String, dynamic>{};
  }

  Future<Map<String, dynamic>> createNewUser(UserModel user) async {
    Response response = await _dio.post(
        '${url}Inserir&ds_email=${user.email}&ds_senha=${user.senha}&nm_usuario=${user.name}&ds_nickname=${user.nickname}');

    return jsonDecode(response.data);
  }

  Future<UserModel> getUser(int id) async {
    final Response response = await _dio.get('${url}Consultar&id_usuario=$id');

    return UserModel.fromJson(jsonDecode(response.data)['dados']);
  }

  Future deleteBook(int id) async {
    await _dio.delete('${url}Excluir&id_livro=$id');
  }
}
