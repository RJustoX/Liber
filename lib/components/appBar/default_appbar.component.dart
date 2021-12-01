import 'package:flutter/material.dart';
import 'package:nicotine/utils/app_colors.dart';

class DefaultAppBarComponent extends AppBar {
  DefaultAppBarComponent(
    BuildContext context, {
    bool haveLeading = false,
  }) : super(
          backgroundColor: AppColors.primaryColor,
          leading: haveLeading
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back))
              : null,
        );
}
