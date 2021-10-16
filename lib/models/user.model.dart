class UserModel {
  UserModel({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.nickname = '',
    this.senha = '',
    this.birthDate,
    this.gender,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id_usuario'] as int;
    name = json['nm_usuario'];
    email = json['ds_email'];
    senha = json['ds_senha'];
    nickname = json['ds_nickname'];
    birthDate = json['dt_nascimento'];
    gender = json['fl_sexo'];
  }

  late int id;
  late String name;
  late String email;
  late String senha;
  late String nickname;
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
