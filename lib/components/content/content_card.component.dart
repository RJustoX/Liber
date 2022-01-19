import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/components/content/user_header.component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/models/_index.dart';

class ContentCardComponent extends StatelessWidget {
  const ContentCardComponent({
    required this.isTip,
    this.content = '',
    this.likes = 0,
    this.title = '',
    this.autor = '',
    this.avatar = '',
    this.category,
    this.reason,
  });

  final bool isTip;
  final String content;
  final int likes;
  final String title;
  final String autor;
  final String avatar;
  final CategoryModel? category;
  final ReasonModel? reason;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserHeaderComponent(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              isTip: isTip,
              autor: autor,
              title: title,
              avatar: avatar,
              category: category,
              reason: reason,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
              child: Text(
                content,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 5.w),
                  child: Icon(
                    FontAwesomeIcons.thumbsUp,
                    color: Colors.blue,
                    size: 22.r,
                  ),
                ),
                Text(
                  '$likes',
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 0, 0, 5.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.thumbsUp,
                        color: Colors.blue,
                        size: 32.r,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Gostei',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
