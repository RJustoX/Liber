import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/views/login.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor('#677DB7'),
        primarySwatch: Colors.green,
      ),
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
