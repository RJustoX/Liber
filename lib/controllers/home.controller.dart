import 'package:nicotine/providers/api.provider.dart';

class HomeController {
  HomeController();
  List<dynamic>? books;
  bool isLoading = true;

  List<dynamic>? getBooks() {
    return books != null ? books : null;
  }

  Future<void> deleteBookByid(int id) async {
    await ApiProvider().deleteBook(id);
  }

  List<Map<String, dynamic>> getFeatures() {
    List<Map<String, dynamic>> featureData = <Map<String, dynamic>>[
      <String, dynamic>{
        'icon': 'assets/healthIcon.png',
        'title': 'Saúde',
        'desc': 'Informações sobre doenças e maleficios derivadas do vicio.'
      },
      <String, dynamic>{
        'icon': 'assets/goalIcon.png',
        'title': 'Metas',
        'desc': 'Estabeleça metas! Coloque em mente seus objetivos e foque para alcançá-los.'
      },
      <String, dynamic>{
        'icon': 'assets/strengIcon.png',
        'title': 'Acompanhamento',
        'desc': 'Acompanhe seu progresso em se desvencilhar do seu vicio.'
      },
    ];
    return featureData;
  }
}
