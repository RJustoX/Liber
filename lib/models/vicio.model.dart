class VicioModel {
  VicioModel(
    this.name,
    this.id,
    this.icon,
  );

  VicioModel.fromJson(Map<String, dynamic> json) {
    id = json['id_vicio'] as int;
    name = json['nm_vicio'];
    score = json['nu_pontuacao'] as int;
    icon = json['nm_logo'];
  }
  late int id;
  late String name;
  late int score;
  String? icon;
}
