class GoalModel {
  GoalModel({
    this.id = 0,
    this.userId = 0,
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
    userId = json['id_usuario'] as int;
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
  late int userId;
  late String title;
  String? description;
  String? avatar;
  int? pontos;
  late double value;
  late bool active;
  late bool done;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userId'] = userId;
    data['title'] = title;
    data['value'] = value;
    data['active'] = active;
    data['done'] = done;
    data['pontos'] = pontos ?? 0;
    data['desc'] = description ?? '';
    data['avatar'] = avatar ?? '';

    return data;
  }
}
