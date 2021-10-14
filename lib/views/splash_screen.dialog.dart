import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/logo.components.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/views/introduction.view.dart';
import 'package:nicotine/views/main.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenDialog extends StatefulWidget {
  @override
  _SplashScreenDialogState createState() => _SplashScreenDialogState();
}

class _SplashScreenDialogState extends State<SplashScreenDialog> {
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getSession().then(
      (value) {
        if (value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => MainView()),
          );
        } else
          setState(() {
            loading = false;
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            LogoComponent(
              size: 120,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: loading
                    ? CircularProgressIndicator()
                    : TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: HexColor('#F4F5F5'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) {
                                return IntroductionView();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Vamos Começar?',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> getSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('token') != null;
  }
}
