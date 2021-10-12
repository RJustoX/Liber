class UserModel {
  UserModel({
    this.id = 0,
    this.name = '',
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['i_id_usuario'] as int;
    name = json['s_nm_usuario'];
    print(name);
  }

  late int id;
  late String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['i_id_usuario'] = id;
    data['s_nm_usuario'] = name;

    return data;
  }
}
