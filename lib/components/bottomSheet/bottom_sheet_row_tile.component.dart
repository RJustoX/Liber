import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/app_colors.dart';

class BottomSheetRowTileComponent extends StatelessWidget {
  const BottomSheetRowTileComponent({
    this.title = 'Label',
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              onTap();
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.r,
              child: Icon(
                icon,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
