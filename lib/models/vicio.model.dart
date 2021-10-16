class VicioModel {
  VicioModel(
    this.name,
    this.id,
    this.icon,
  );

  VicioModel.fromJson(Map<String, dynamic> json) {
    id = json['id_vicio'] as int;
    name = json['nm_vicio'];
    icon = json['nm_logo'];
  }

  late String name;
  late int id;
  String? icon;
}
