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

    user = UserModel.fromJson(json['user'][0]);
  }

  int? id;
  late int idVicio;
  late int idReason;
  late bool anonimo;
  late String content;
  late String title;
  late int likes;
  UserModel? user;
}
