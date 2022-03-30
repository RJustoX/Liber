import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/models/user.model.dart';

class RankingTileComponent extends StatefulWidget {
  const RankingTileComponent({
    required this.index,
    required this.user,
    this.userPosition = false,
  });
  final UserRankingModel user;
  final int index;
  final bool userPosition;

  @override
  State<RankingTileComponent> createState() => _RankingTileComponentState();
}

class _RankingTileComponentState extends State<RankingTileComponent> {
  String? avatarUrl;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 15.h, 20.w, 15.h),
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            child: Center(
              child: Text(
                widget.userPosition ? '${widget.index}' : '${widget.index + 4}',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
            child: CircleAvatar(
              backgroundImage: !loading && widget.user.avatar != '' && widget.user.avatar != null
                  ? CachedNetworkImageProvider(widget.user.avatar!)
                  : null,
              child: widget.user.avatar == '' ? Icon(Icons.person) : null,
            ),
          ),
          Text(
            widget.user.nickname,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Icon(
            FontAwesomeIcons.trophy,
            color: HexColor('#6A7188'),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            '${widget.user.score}',
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: HexColor('#6A7188'),
            ),
          )
        ],
      ),
    );
  }
}
