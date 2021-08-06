import 'package:flutter/material.dart';
import 'package:nicotine/views/login.view.dart';
import 'package:nicotine/views/register.view.dart';
import 'package:nicotine/views/signup.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageController _pController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: PageView(
          controller: _pController,
          children: <Widget>[
            RegisterView(),
            LoginView(_pController),
            SignUpView(),
          ],
        ));
  }
}
