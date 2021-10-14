class UserModel {
  UserModel({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.nickname = '',
    this.senha = '',
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id_usuario'] as int;
    name = json['nm_usuario'];
    email = json['ds_email'];
    senha = json['ds_senha'];
    nickname = json['ds_nickname'];
  }

  late int id;
  late String name;
  late String email;
  late String senha;
  late String nickname;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_usuario'] = id;
    data['nm_usuario'] = name;
    data['ds_email'] = email;

    return data;
  }
}
