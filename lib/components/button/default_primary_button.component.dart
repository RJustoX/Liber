import 'package:flutter/material.dart';
import 'package:nicotine/utils/app_colors.dart';

class DefaultPrimaryButtonComponent extends TextButton {
  DefaultPrimaryButtonComponent({
    required Function()? onTap,
    required String title,
    String? loadingTitle,
    bool loading = false,
    bool revertColors = false,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                !loading ? title : loadingTitle ?? title,
                style: TextStyle(
                  color: revertColors ? AppColors.primaryColor : Colors.white,
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
            backgroundColor: revertColors
                ? loading
                    ? Colors.white.withOpacity(0.6)
                    : Colors.white
                : loading
                    ? AppColors.primaryColor.withOpacity(0.6)
                    : AppColors.primaryColor,
            minimumSize: Size(double.maxFinite, 45.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        );
}
