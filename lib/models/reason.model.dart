class ReasonModel {
  ReasonModel({
    this.id,
    this.name = '',
    this.logo = '',
    this.sex = 1,
  });

  ReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id_motivo'] as int;
    name = json['nm_motivo'];
    logo = json['nm_logo'];
    sex = json['fl_sexo'] ?? 1;
  }

  int? id;
  late String name;
  late String logo;
  late int sex;
}
