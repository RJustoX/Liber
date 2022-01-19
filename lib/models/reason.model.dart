class ReasonModel {
  ReasonModel({
    this.id,
    this.name = '',
    this.logo = '',
    this.sex = '',
    this.selected = false,
  });

  ReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id_motivo'] as int;
    name = json['nm_motivo'];
    logo = json['nm_logo'];
    sex = json['fl_sexo'];
    selected = false;
  }

  int? id;
  late String name;
  late String logo;
  late String sex;
  late bool selected;
}
