class CategoryModel {
  CategoryModel({
    this.id,
    this.name = '',
    this.color = '',
    this.icon,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id_categoria'] as int;
    name = json['ds_nome'];
    color = json['nm_cor'];
    icon = json['nm_icon'] ?? '';
  }

  int? id;
  late String color;
  late String name;
  String? icon;
}
