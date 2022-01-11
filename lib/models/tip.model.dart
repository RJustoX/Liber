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

    user = UserModel.fromJson(json['user'][0]);
  }

  int? id;
  late int idVicio;
  late int idCategory;
  late bool anonimo;
  late String content;
  late int likes;
  UserModel? user;
}
