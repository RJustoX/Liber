import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/button/default_primary_button.component.dart';
import 'package:nicotine/components/input/default_text_input.component.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewGoalView extends StatefulWidget {
  const NewGoalView();

  @override
  _NewGoalViewState createState() => _NewGoalViewState();
}

class _NewGoalViewState extends State<NewGoalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    color: AppColors.primaryColor,
                    height: 250.h,
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 50.r,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 35.w, top: 10.h),
                          child: Text(
                            'Nova meta',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 36.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 30.w),
                    color: AppColors.backgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DefaultTextInputComponent(
                          title: 'Nome da meta',
                        ),
                        const SizedBox(height: 20.0),
                        DefaultTextInputComponent(
                          title: 'Deixe alguma anotação',
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Ativar meta',
                          style: TextStyle(
                            color: HexColor('#B0B4C0'),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Transform.scale(
                          scale: 1.50,
                          child: Checkbox(
                            value: false,
                            onChanged: (bool? value) {},
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        DefaultPrimaryButtonComponent(onTap: () {}, title: 'Salvar'),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 150.h,
                left: (0.5.sw - 100.h),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.h),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 80.h,
                        ),
                        Text('Adicionar imagem',
                            style: TextStyle(
                              color: AppColors.primaryFontColor,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
