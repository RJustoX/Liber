import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nicotine/views/register.view.dart';
import 'package:nicotine/views/signup.view.dart';
import 'home.view.dart';

class IntroductionView extends StatefulWidget {
  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showDoneButton: true,
      showNextButton: true,
      showSkipButton: false,
      isTopSafeArea: true,
      done: SizedBox(),
      nextColor: Colors.blue,
      next: Icon(
        Icons.arrow_forward,
        size: 28,
      ),
      onDone: () {},
      pages: [
        PageViewModel(
          titleWidget: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              'Boas Vindas!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: 'Seja bem vindo ao Nicotine!',
        ),
        PageViewModel(
          titleWidget: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              'Este é o inicio',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: 'O primeiro maço é o mais dificil!',
        ),
        PageViewModel(
          titleWidget: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              'Quase tudo pronto!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bodyWidget: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Text(
                  'Antes de começarmos, precisamos saber se já tem uma conta no nosso aplicativo, tendo uma conta você garante que nunca perderá seus dados e progresso!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: ExactAssetImage('assets/loginSticker.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: HexColor('#677DB7'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(
                        color: HexColor('#677DB7'),
                      ),
                    ),
                    child: Text(
                      'Cadastrar-se',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) {
                            return RegisterView();
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(
                        color: HexColor('#677DB7'),
                      ),
                    ),
                    child: Text(
                      'Já tenho uma conta',
                      style: TextStyle(
                        color: HexColor('#677DB7'),
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) {
                            return SignUpView();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
