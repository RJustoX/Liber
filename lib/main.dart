import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nicotine/stores/recordes_repository.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/views/splash_screen.dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'game/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserStore>.value(value: UserStore()),
        Provider<VicioStore>.value(value: VicioStore()),
        Provider<RecordesRepository>(create: (_) => RecordesRepository()),
        ProxyProvider<RecordesRepository, GameController>(
          update: (_, repo, __) => GameController(recordesRepository: repo),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(500, 1000),
        builder: () => MaterialApp(
          home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Deu bretch!'));
              }

              if (snapshot.hasData) {
                return SplashScreenDialog();
              }
              return CircularProgressIndicator();
            },
          ),
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Nicotine',
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('pt', 'BR'),
            Locale('en', 'US'),
          ],
        ),
      ),
    );
  }
}
