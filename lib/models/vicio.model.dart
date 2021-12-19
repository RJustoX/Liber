class VicioModel {
  VicioModel(
    this.name,
    this.id,
    this.icon,
  );

  VicioModel.fromJson(Map<String, dynamic> json) {
    id = json['id_vicio'] as int;
    print(id);
    name = json['nm_vicio'];
    print(name);
    icon = json['nm_logo'];
    print(icon);
  }

  late String name;
  late int id;
  String? icon;
}
