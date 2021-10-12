class UserModel {
  UserModel({
    this.id = 0,
    this.name = '',
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id_usuario'] as int;
    name = json['nm_usuario'];
    email = json['ds_email'];
  }

  late int id;
  late String name;
  late String email;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_usuario'] = id;
    data['nm_usuario'] = name;
    data['ds_email'] = email;

    return data;
  }
}
