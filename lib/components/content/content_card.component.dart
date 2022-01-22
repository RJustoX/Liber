import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/components/content/user_header.component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/controllers/content.controller.dart';
import 'package:nicotine/models/_index.dart';

// ignore: must_be_immutable
class ContentCardComponent extends StatefulWidget {
  ContentCardComponent({
    required this.isTip,
    this.content = '',
    this.likes = 0,
    this.title = '',
    this.autor = '',
    this.avatar = '',
    this.category,
    this.reason,
    this.controller,
    this.liked = false,
    required this.data,
  });

  final bool isTip;
  final String content;
  int likes;
  final String title;
  final String autor;
  final String avatar;
  bool liked;
  final CategoryModel? category;
  final ReasonModel? reason;
  final ContentController? controller;
  final Map<String, dynamic> data;

  @override
  State<ContentCardComponent> createState() => _ContentCardComponentState();
}

class _ContentCardComponentState extends State<ContentCardComponent> {
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
              isTip: widget.isTip,
              autor: widget.autor,
              title: widget.title,
              avatar: widget.avatar,
              category: widget.category,
              reason: widget.reason,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
              child: Text(
                widget.content,
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
                  '${widget.likes}',
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.liked = !widget.liked;
                        print(widget.liked);
                        if (widget.liked) {
                          widget.likes++;
                          widget.controller!.likeContent(widget.data, true);
                        } else {
                          widget.likes--;
                          widget.controller!.likeContent(widget.data, false);
                        }
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.thumbsUp,
                          color: Colors.blue,
                          size: widget.liked ? 35.r : 32.r,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Gostei',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: !widget.liked ? Colors.black : Colors.blue,
                          ),
                        ),
                      ],
                    ),
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
