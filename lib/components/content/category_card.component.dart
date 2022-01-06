import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCardComponent extends StatelessWidget {
  const CategoryCardComponent();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
            color: Colors.amber[100],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.frownOpen,
                    color: Colors.black,
                    size: 60.r,
                  ),
                  SizedBox(height: 10.h),
                  Text('Ansiedade',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      )),
                ],
              ),
            )));
  }
}
