import 'package:nicotine/controllers/main.controller.dart';
import 'package:nicotine/views/health/health.view.dart';
import 'package:nicotine/views/home/goal.view.dart';
import 'package:nicotine/views/progress/calendar.dialog.dart';
import 'package:nicotine/views/progress/progress.view.dart';

class HomeController extends MainController {
  HomeController();
  bool isLoading = true;

  String getInitialMessage() {
    String result = '';
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour <= 12) {
      result = 'Bom dia';
    } else if (hour >= 13 && hour <= 18) {
      result = 'Boa tarde';
    } else {
      result = 'Boa noite';
    }
    return '$result ${getUserName()}';
  }

  List<Map<String, dynamic>> getFeatures() {
    List<Map<String, dynamic>> featureData = <Map<String, dynamic>>[
      <String, dynamic>{
        'icon': 'assets/healthIcon.png',
        'title': 'Saúde',
        'desc': 'Informações sobre doenças e maleficios derivadas do vicio.',
        'route': HealthView(),
      },
      <String, dynamic>{
        'icon': 'assets/goalIcon.png',
        'title': 'Metas',
        'desc': 'Estabeleça metas! Coloque em mente seus objetivos e foque para alcançá-los.',
        'route': GoalView(),
      },
      <String, dynamic>{
        'icon': 'assets/strengIcon.png',
        'title': 'Acompanhamento',
        'desc': 'Acompanhe seu progresso em se desvencilhar do seu vicio.',
        'route': ProgressView(),
      },
    ];
    return featureData;
  }
}
