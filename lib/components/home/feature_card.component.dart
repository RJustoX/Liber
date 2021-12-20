import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureCardComponent extends StatelessWidget {
  const FeatureCardComponent(
    this.icon,
    this.title,
    this.desc, {
    this.route,
  });

  final String icon;
  final String title, desc;
  final Widget? route;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: EdgeInsets.fromLTRB(70.0.r, 15.0, 20.0, 20.0),
            margin: EdgeInsets.only(left: 50.r),
            height: 0.16.sh,
            width: 400.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0.r),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 26.0.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => route!));
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          heightFactor: 1.5,
          child: CircleAvatar(
            radius: 50.r,
            backgroundColor: HexColor('#FCE0A2'),
            child: Image.asset(icon),
          ),
        ),
      ],
    );
  }
}
