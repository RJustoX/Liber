import 'package:nicotine/game/game.view.dart';
import 'package:nicotine/views/health/health.view.dart';
import 'package:nicotine/views/home/goal.view.dart';
import 'package:nicotine/views/progress/progress.view.dart';

class HomeController {
  HomeController();
  bool isLoading = true;

  String getInitialMessage(String name) {
    String result = '';
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour <= 12) {
      result = 'Bom dia';
    } else if (hour >= 13 && hour <= 18) {
      result = 'Boa tarde';
    } else {
      result = 'Boa noite';
    }
    return '$result $name';
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
        'icon': 'assets/gameicon.png',
        'title': 'Distração',
        'desc': 'Lute contra a abstinencia se distraindo e exercitando sua memória!',
        'route': GameView(),
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
