import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/models/category.model.dart';

class CategoryCardComponent extends StatelessWidget {
  const CategoryCardComponent({
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135.w,
      child: Card(
        elevation: category.selected ? 8.0 : 1.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        color: HexColor(category.color != '' ? category.color : '#ffffff'),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                category.icon,
                color: Colors.black,
                size: 60.r,
              ),
              SizedBox(height: 10.h),
              Text(
                category.name,
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
