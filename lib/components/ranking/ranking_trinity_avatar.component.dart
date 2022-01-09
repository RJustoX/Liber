import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/models/user.model.dart';

class RankingTrinityAvatarComponent extends StatelessWidget {
  const RankingTrinityAvatarComponent({
    required this.user,
    this.position = 1,
  });

  final UserRankingModel user;
  final int position;

  Color getColor() {
    Color result = Colors.white;
    if (position == 1)
      result = Colors.amber[600]!;
    else if (position == 2)
      result = Colors.grey[400]!;
    else
      result = Colors.yellow[900]!;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: position == 1 ? EdgeInsets.fromLTRB(35.w, 0, 35.w, 50.h) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50.r,
            backgroundImage: user.avatar != '' ? CachedNetworkImageProvider(user.avatar!) : null,
            child: user.avatar == '' ? Icon(Icons.person, size: 45.r) : null,
          ),
          Text(
            user.nickname,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.trophy,
                color: getColor(),
                size: position == 1
                    ? 33.r
                    : position == 2
                        ? 26.r
                        : 24.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Text(
                '${user.score}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: position == 1
                      ? 26.sp
                      : position == 2
                          ? 22.sp
                          : 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
