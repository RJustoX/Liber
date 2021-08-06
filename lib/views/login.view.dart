import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/logo.components.dart';

class LoginView extends StatefulWidget {
  LoginView(
    this._pageController,
  );
  final PageController _pageController;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: HexColor('#1B2A41'),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage('assets/loginbg.jpg'),
            colorFilter: ColorFilter.mode(
              HexColor('#1B2A41').withOpacity(0.15),
              BlendMode.dstATop,
            ),
          ),
        ),
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
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: HexColor('#F4F5F5'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    widget._pageController.jumpToPage(2);
                  },
                  child: Text(
                    'Vamos Começar?',
                    style: TextStyle(
                      color: HexColor('#1B2A41'),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60.0, 30, 60.0, 0.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: HexColor('#F4F5F5'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    widget._pageController.jumpToPage(0);
                  },
                  child: Text(
                    'Ja tenho uma conta',
                    style: TextStyle(
                        color: HexColor('#1B2A41'),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
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
}
