import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/views/home.view.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(500, 1000),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Nicotine',
        theme: ThemeData(
          primaryColor: HexColor('#003476'),
          splashColor: HexColor('#CAD4DF'),
          backgroundColor: HexColor('#f4f5f5'),
        ),
        home: HomeView(),
      ),
    );
  }
}
