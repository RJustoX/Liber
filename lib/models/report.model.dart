import 'package:nicotine/models/user.model.dart';

class ReportModel {
  ReportModel({
    this.id,
    this.idVicio = 0,
    this.idReason = 0,
    this.title = '',
    this.content = '',
    this.anonimo = false,
    this.likes = 0,
    this.user,
  });

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id_conteudo'] as int;
    idVicio = json['id_vicio'] as int;
    idReason = json['id_motivo'] as int;
    title = json['nm_titulo'] ?? '';
    content = json['ds_relato'] ?? '';
    likes = (json['nu_likes'] ?? 0) as int;
    anonimo = json['fl_anonimo'] ?? true;
    liked = json['liked'] as bool;

    user = UserModel.fromJson(json['user'][0]);
  }

  int? id;
  int? userId;
  late int idVicio;
  late int idReason;
  late bool anonimo;
  late bool liked;
  late String content;
  late String title;
  late int likes;
  UserModel? user;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_conteudo'] = id;
    data['id_usuario'] = userId!;
    data['id_vicio'] = idVicio;
    data['id_motivo'] = idReason;
    data['fl_anonimo'] = anonimo;
    data['ds_relato'] = content;
    data['nm_titulo'] = title;
    data['nu_likes'] = 0;

    return data;
  }
}
