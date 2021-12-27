class VicioModel {
  VicioModel(
    this.name,
    this.id,
    this.icon,
  );

  VicioModel.fromJson(Map<String, dynamic> json) {
    id = json['id_vicio'] as int;
    name = json['nm_vicio'];
    score = (json['nu_pontuacao'] ?? 0) as int;
    icon = json['nm_logo'];
  }

  late int id;
  late String name;
  int? score;
  String? icon;
}
