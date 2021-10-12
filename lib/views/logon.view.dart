import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/login.view.dart';

import 'home/home.view.dart';

class LogonView extends StatefulWidget {
  @override
  _LogonViewState createState() => _LogonViewState();
}

class _LogonViewState extends State<LogonView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> validacao() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          color: AppColors.primaryColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 140,
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'Nicotine',
                        style: TextStyle(
                          color: HexColor('#F4F5F5'),
                          fontSize: 38.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, bottom: 20.0, top: 30),
                  child: Text(
                    'Cadastro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                      color: AppColors.backgroundColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Bem vindo',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Estamos contentes por ter vindo!',
                            style: TextStyle(
                              color: HexColor('#6A7188'),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                            child: Text(
                              'Seu Nome',
                              style: TextStyle(
                                color: HexColor('#B0B4C0'),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Insira seu nome...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
                              fillColor: HexColor('#CAD4DF'),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Campo não preenchido';
                              } else
                                return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                            child: Text(
                              'Seu Nickname',
                              style: TextStyle(
                                color: HexColor('#B0B4C0'),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Insira seu Nickname...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
                                fillColor: HexColor('#CAD4DF'),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo não preenchido';
                                } else
                                  return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Seu Email',
                              style: TextStyle(
                                color: HexColor('#B0B4C0'),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Insira seu email...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
                                fillColor: HexColor('#CAD4DF'),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo não preenchido';
                                } else
                                  return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Sua Senha',
                              style: TextStyle(
                                color: HexColor('#B0B4C0'),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Insira sua senha...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
                                fillColor: HexColor('#CAD4DF'),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo não preenchido';
                                } else
                                  return null;
                              },
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  minimumSize: Size(double.maxFinite, 45.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await validacao().then((value) {
                                      if (value) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (_) {
                                              return HomeView();
                                            },
                                          ),
                                        );
                                      } else {
                                        ToastUtil.error('Usuário não cadastrado');
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(
                                    color: AppColors.backgroundColor,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<void>(
                                    builder: (_) {
                                      return LoginView();
                                    },
                                  ),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Já tem uma conta?',
                                      style: TextStyle(
                                        color: HexColor('#6A7188'),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' faça login',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
