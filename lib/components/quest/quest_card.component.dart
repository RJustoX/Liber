import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestCardComponent extends StatelessWidget {
  const QuestCardComponent();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 60.h),
            height: 0.35.sh,
            width: 0.9.sw,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 100.h),
                  child: Column(
                    children: <Widget>[
                      Text('Questionário aleatorio bla bla bla', style: TextStyle(fontSize: 22.sp))
                    ],
                  ),
                )),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 70.h,
            child: Image.asset('assets/vicioLogo/tabagismoLogo.png'),
          ),
        ),
      ],
    );
  }
}
