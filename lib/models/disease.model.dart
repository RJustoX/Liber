class DiseaseModel {
  DiseaseModel({
    this.title = '',
    this.description = '',
    this.cases = '',
    this.ref = '',
  });

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    title = json['nm_doenca'];
    description = json['desc_doenca'];
    ref = json['link_doenca'];
    cases = json['nu_casos'];
  }

  late String title;
  late String description;
  late String cases;
  late String ref;
}
