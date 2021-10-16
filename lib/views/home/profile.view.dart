import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/controllers/home.controller.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/views/login.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(
    this._controller,
  );

  final HomeController _controller;

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  color: AppColors.primaryColor,
                  height: 250.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 50.r,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Atenção!'),
                                        content: Text('Quer mesmo sair da sua conta?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancelar')),
                                          TextButton(
                                              onPressed: () async {
                                                SharedPreferences sharedPreferences =
                                                    await SharedPreferences.getInstance();
                                                await sharedPreferences.clear();
                                                Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) => LoginView(),
                                                  ),
                                                );
                                              },
                                              child: Text('Confirmar'))
                                        ],
                                      ));
                            },
                            icon: Icon(
                              FontAwesomeIcons.edit,
                              color: Colors.white,
                              size: 35.r,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35.w, top: 10.h),
                        child: Text(
                          widget._controller.getUser().nickname,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35.w),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.trophy,
                              size: 22.r,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              '250',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 30.w),
                  color: AppColors.backgroundColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            child: Image.asset('assets/vicioLogo/tabagismoLogo.png'),
                            radius: 40.r,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          CircleAvatar(
                            child: Image.asset('assets/vicioLogo/alcolismoLogo.png'),
                            radius: 40.r,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40.r,
                            ),
                            radius: 40.r,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0.h),
                        padding: EdgeInsets.all(20.0.r),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget._controller.getUser().name,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              widget._controller.getUser().email,
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0.r),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Maior tempo sem fazer uso:',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              '3 dias',
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Recorde de logins consecutivos:',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              '8 dias',
                              style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 150.h,
              left: (0.5.sw - 100.h),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 100.h,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 80.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
