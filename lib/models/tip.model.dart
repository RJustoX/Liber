import 'package:nicotine/models/user.model.dart';

class TipModel {
  TipModel({
    this.id,
    this.idVicio = 0,
    this.idCategory = 0,
    this.content = '',
    this.anonimo = false,
    this.likes = 0,
    this.user,
  });

  TipModel.fromJson(Map<String, dynamic> json) {
    id = json['id_conteudo'] as int;
    idVicio = json['id_vicio'] as int;
    idCategory = json['id_categoria'] as int;
    content = json['ds_dica'] ?? '';
    likes = (json['nu_likes'] ?? 0) as int;
    anonimo = json['fl_anonimo'] ?? true;

    liked = json['liked'] as bool;
    user = UserModel.fromJson(json['user'][0]);
  }

  int? id;
  late int idVicio;
  int? userId;
  late int idCategory;
  late bool anonimo;
  late bool liked;
  late String content;
  late int likes;
  UserModel? user;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_conteudo'] = id;
    data['id_usuario'] = userId!;
    data['id_vicio'] = idVicio;
    data['id_categoria'] = idCategory;
    data['fl_anonimo'] = anonimo;
    data['ds_dica'] = content;
    data['nu_likes'] = 0;

    return data;
  }
}
