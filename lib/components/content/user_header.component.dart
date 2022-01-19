import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/models/_index.dart';

class UserHeaderComponent extends StatelessWidget {
  const UserHeaderComponent({
    this.padding,
    required this.isTip,
    this.title = '',
    this.avatar = '',
    this.autor = '',
    this.category,
    this.reason,
  });

  final EdgeInsets? padding;
  final CategoryModel? category;
  final ReasonModel? reason;
  final bool isTip;
  final String title, avatar, autor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: padding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CircleAvatar(
              radius: 30.r,
              backgroundImage: avatar != '' ? CachedNetworkImageProvider(avatar) : null,
              child: avatar == '' ? Icon(Icons.person, size: 45.r) : null,
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: SizedBox(
                width: 0.6.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      isTip ? autor : title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    if (isTip)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Badge(
                          padding: EdgeInsets.all(5),
                          badgeColor: HexColor(category!.color),
                          shape: BadgeShape.square,
                          borderRadius: BorderRadius.circular(15.r),
                          badgeContent: Text(
                            category!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      )
                    else
                      Text(
                        'Por: $autor',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (!isTip)
              CircleAvatar(
                child:
                    Image.asset(reason!.logo != '' ? reason!.logo : 'assets/motivoLogo/money.png'),
              ),
          ],
        ));
  }
}
