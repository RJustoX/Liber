import 'package:nicotine/models/vicio.model.dart';

class UserModel {
  UserModel({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.nickname = '',
    this.senha = '',
    this.birthDate,
    this.gender = 0,
    this.vicios,
    this.savings = 0.0,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id_usuario'] as int;
    avatar = json['nm_avatar'] ?? '';
    name = json['nm_usuario'] ?? '';
    email = json['ds_email'] ?? '';
    senha = json['ds_senha'] ?? '';
    nickname = json['ds_nickname'];
    gender = json['fl_sexo'] != null ? int.parse(json['fl_sexo']) : null;
    savings = (json['vl_economizado'] ?? 0.0).toDouble();

    if (json['dt_nascimento'] != null &&
        json['dt_nascimento'] != '' &&
        json['dt_nascimento'] is String) {
      birthDate = DateTime.parse(json['dt_nascimento']);
    }
  }

  late int id;
  String? avatar;
  late String name;
  late String email;
  late String senha;
  late String nickname;
  late double savings;
  List<VicioModel>? vicios;
  DateTime? birthDate;
  int? gender;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_usuario'] = id;
    data['nm_usuario'] = name;
    data['ds_email'] = email;

    return data;
  }
}

class UserRankingModel {
  UserRankingModel({
    this.id = 0,
    this.nickname = '',
    this.score = 0,
  });

  UserRankingModel.fromJson(Map<String, dynamic> json) {
    id = json['id_usuario'] as int;
    avatar = json['nm_avatar'];
    nickname = json['ds_nickname'] ?? '';

    score = (json['nu_pontuacao'] ?? 0) as int;

    if (json['posicao'] != null) position = int.parse(json['posicao']);
  }

  late int id;
  String? avatar;
  int? position;
  late String nickname;
  late int score;
}
