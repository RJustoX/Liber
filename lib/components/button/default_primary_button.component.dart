import 'package:flutter/material.dart';
import 'package:nicotine/utils/app_colors.dart';

class DefaultPrimaryButtonComponent extends TextButton {
  DefaultPrimaryButtonComponent({
    required Function()? onTap,
    required String title,
    String? loadingTitle,
    bool loading = false,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                !loading ? title : loadingTitle ?? title,
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: loading ? 10.0 : 0.0,
              ),
              loading ? CircularProgressIndicator() : SizedBox(),
            ],
          ),
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor:
                loading ? AppColors.primaryColor.withOpacity(0.6) : AppColors.primaryColor,
            minimumSize: Size(double.maxFinite, 45.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        );
}
