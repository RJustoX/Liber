import 'package:nicotine/models/user.model.dart';

class NewContentModel {
  NewContentModel({
    this.id,
    this.idVicio = 0,
    this.idReason = 0,
    this.title = '',
    this.content = '',
    this.anonimo = false,
    this.likes = 0,
    this.user,
    this.idCategory = 0,
    this.isOwner = true,
    this.liked = false,
    this.userId,
  });

  int? id;
  int? userId;
  int? idVicio;
  int idReason;
  int idCategory;
  bool anonimo;
  bool liked;
  bool isOwner;
  String content;
  String title;
  int likes;
  UserModel? user;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_conteudo'] = id;
    data['id_usuario'] = userId;
    data['id_vicio'] = idVicio;
    data['id_motivo'] = idReason;
    data['id_categoria'] = idCategory;
    data['fl_anonimo'] = anonimo;
    data['ds_relato'] = content;
    data['ds_dica'] = content;
    data['nm_titulo'] = title;
    data['nu_likes'] = 0;

    return data;
  }
}
