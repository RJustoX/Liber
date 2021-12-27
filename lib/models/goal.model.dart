class GoalModel {
  GoalModel({
    this.id = 0,
    this.title = '',
    this.description,
    this.avatar,
    this.pontos,
    this.value = 0.0,
    this.active = false,
    this.done = false,
  });

  GoalModel.fromJson(Map<String, dynamic> json) {
    id = json['id_meta'] as int;
    print(id);
    title = json['nm_meta'];
    print(title);
    description = json['ds_meta'] ?? '';
    print(description);
    avatar = json['nm_logo'];
    pontos = (json['nu_pontuacao'] ?? 0) as int;
    print(pontos);
    value = (json['vl_meta'] ?? 0.0).toDouble();
    print(value);
    active = json['fl_ativa'] ?? false;
    print(active);
    done = json['fl_concluida'] ?? false;
    print(done);
  }

  late int id;
  late String title;
  String? description;
  String? avatar;
  int? pontos;
  late double value;
  late bool active;
  late bool done;
}
