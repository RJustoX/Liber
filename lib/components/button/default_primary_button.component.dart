import 'package:flutter/material.dart';
import 'package:nicotine/utils/app_colors.dart';

class DefaultPrimaryButtonComponent extends TextButton {
  DefaultPrimaryButtonComponent({
    required Function()? onTap,
    required String title,
  }) : super(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.backgroundColor,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            minimumSize: Size(double.maxFinite, 45.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        );
}
