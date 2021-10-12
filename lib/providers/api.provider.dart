import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nicotine/models/login.model.dart';
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

  Future deleteBook(int id) async {
    await _dio.delete('${url}Excluir&id_livro=$id');
  }
}
