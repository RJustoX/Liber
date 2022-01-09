import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/models/reason.model.dart';

class ReasonCardComponent extends StatelessWidget {
  const ReasonCardComponent({
    required this.reason,
  });

  final ReasonModel reason;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135.w,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        color: Colors.white,
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
