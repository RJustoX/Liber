import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/controllers/login.controller.dart';
import 'package:nicotine/models/login.model.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/logon.view.dart';
import 'package:nicotine/views/main.view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginModel _model = LoginModel();
  LoginController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = LoginController();
  }

  void onError(dynamic error, dynamic stackTrace) {
    ToastUtil.error('Usuário e/ou senha incorretos');
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
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Form(
              key: _formKey,
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
                      'Login',
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
                              'Bem vindo de volta',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Estamos contentes por ter voltado!',
                              style: TextStyle(
                                color: HexColor('#6A7188'),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                              child: Text(
                                'Seu Email',
                                style: TextStyle(
                                  color: HexColor('#B0B4C0'),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Insira seu email...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
                                fillColor: HexColor('#CAD4DF'),
                                filled: true,
                              ),
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'Campo não preenchido';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                                  return 'Por favor, digite um email válido';
                                }
                                return null;
                              },
                              onSaved: (email) {
                                _model.email = email!.trim();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 10.0),
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
                                onSaved: (password) {
                                  _model.password = password!;
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
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
                                      _formKey.currentState!.save();
                                      await _controller!.login(_model).then((_) {
                                        ToastUtil.success('Bem vindo!');
                                        return Navigator.of(context).pushReplacement(
                                          MaterialPageRoute<void>(
                                            builder: (_) {
                                              return MainView();
                                            },
                                          ),
                                        );
                                      }).catchError(onError);
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
                                        return LogonView();
                                      },
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Ainda não tem uma conta?',
                                        style: TextStyle(
                                          color: HexColor('#6A7188'),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' Cadastre-se',
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
      ),
    );
  }
}
