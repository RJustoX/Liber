import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/models/reason.model.dart';

class ReasonCardComponent extends StatelessWidget {
  const ReasonCardComponent({
    required this.reason,
  });

  final ReasonModel reason;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145.w,
      child: Card(
        elevation: reason.selected ? 8 : 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 45.r,
                child: Image.asset(reason.logo != '' ? reason.logo : 'assets/motivoLogo/money.png'),
              ),
              SizedBox(height: 10.h),
              Text(
                reason.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
