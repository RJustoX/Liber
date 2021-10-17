import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/controllers/login.controller.dart';
import 'package:nicotine/models/login.model.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/logon.view.dart';
import 'package:nicotine/views/main.view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            color: AppColors.primaryColor,
            width: 1.sw,
            height: 1.sh,
            child: Padding(
              padding: EdgeInsets.only(top: 80.h),
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
                            width: 140.0.r,
                            height: 140.0.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70.r),
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          Text(
                            'Nicotine',
                            style: TextStyle(
                              color: HexColor('#F4F5F5'),
                              fontSize: 50.0.sp,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0.w, bottom: 25.0.h, top: 30.h),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45.0.sp,
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
                          padding: EdgeInsets.fromLTRB(50.0.w, 40.0.h, 50.0.w, 40.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Bem vindo de volta',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 34.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Estamos contentes por ter voltado!',
                                style: TextStyle(
                                  color: HexColor('#6A7188'),
                                  fontSize: 22.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25.h, bottom: 15.0.h),
                                child: Text(
                                  'Seu Email',
                                  style: TextStyle(
                                    color: HexColor('#B0B4C0'),
                                    fontSize: 22.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: setTextFieldDecoration('Insira seu email...'),
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
                                padding: EdgeInsets.only(top: 25.0.h, bottom: 15.0.h),
                                child: Text(
                                  'Sua Senha',
                                  style: TextStyle(
                                    color: HexColor('#B0B4C0'),
                                    fontSize: 22.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: setTextFieldDecoration('Insira sua senha...'),
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
                                      fontSize: 21.0.sp),
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    minimumSize: Size(double.maxFinite, 55.h),
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
                                      fontSize: 32.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
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
                                            fontSize: 21.0.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' Cadastre-se',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 21.0.sp,
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
      ),
    );
  }

  InputDecoration setTextFieldDecoration(String hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 25.0.h, horizontal: 20.0.w),
      hintText: hint,
      hintStyle: TextStyle(fontSize: 22.sp),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0.r),
          borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
      fillColor: HexColor('#CAD4DF'),
      filled: true,
    );
  }
}
