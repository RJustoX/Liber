import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppBarComponent extends AppBar {
  DefaultAppBarComponent(
    BuildContext context, {
    String title = '',
    TabBarComponent? tabBar,
    bool haveLeading = false,
    bool centerTitle = false,
    String? vicioIcon,
  }) : super(
          backgroundColor: AppColors.primaryColor,
          leading: haveLeading
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 36.0,
                  ),
                )
              : const SizedBox(),
          centerTitle: centerTitle,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28.sp,
            ),
          ),
          actions: <Widget>[
            if (vicioIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: CircleAvatar(
                  child: Image.asset(vicioIcon),
                  radius: 16,
                ),
              ),
          ],
          bottom: tabBar,
        );
}
