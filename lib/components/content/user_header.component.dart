import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHeaderComponent extends StatelessWidget {
  const UserHeaderComponent({
    this.padding,
    required this.isTip,
  });

  final EdgeInsets? padding;
  final bool isTip;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: padding,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30.r,
              backgroundImage: CachedNetworkImageProvider(
                  'https://firebasestorage.googleapis.com/v0/b/liber-a964e.appspot.com/o/images%2F21%2Fgoals%2Fimg-2021-12-29%2011%3A46%3A20.123127.jpg?alt=media&token=d6bbc17c-5251-4819-932d-1bfb8449dd99'),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isTip ? 'Anonimo' : 'Antigos prazeres esquecidos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                if (isTip)
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Badge(
                      padding: EdgeInsets.all(5),
                      badgeColor: Colors.amber[100]!,
                      shape: BadgeShape.square,
                      borderRadius: BorderRadius.circular(15.r),
                      badgeContent: Text(
                        'Ansiedade',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    'Por: Rafael Justo',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
              ],
            )
          ],
        ));
  }
}
