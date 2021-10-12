import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/views/home.view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:nicotine/views/login.view.dart';

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
      theme: ThemeData(
        primaryColor: HexColor('#003476'),
        splashColor: HexColor('#CAD4DF'),
        backgroundColor: HexColor('#f4f5f5'),
      ),
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: LoginView(),
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
