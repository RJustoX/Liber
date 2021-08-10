import 'package:flutter/material.dart';
import 'package:nicotine/views/main.view.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: MainView(),
      // PageView(
      //   controller: _pController,
      //   children: <Widget>[
      //     RegisterView(),
      //     LoginView(_pController),
      //     SignUpView(),
      //   ],
      // ),
    );
  }
}
