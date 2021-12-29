import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/goal/goal.dialog.dart';
import 'package:nicotine/controllers/goal.controller.dart';
import 'package:nicotine/models/goal.model.dart';

class GoalCardComponent extends StatelessWidget {
  const GoalCardComponent(this.goal, this.callback, this.controller);
  final GoalModel goal;
  final VoidCallback callback;
  final GoalController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) {
              return GoalDialog(
                goal: goal,
                callback: callback,
                controller: controller,
              );
            },
          ),
          child: Container(
            width: double.maxFinite,
            height: 150.h,
            margin: goal.avatar != '' ? EdgeInsets.only(left: 30.r) : null,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0.r)),
              child: Padding(
                padding: EdgeInsets.fromLTRB(goal.avatar != '' ? 80.w : 20.w, 20.h, 20.h, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          goal.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(Icons.circle, color: goal.active ? Colors.green : Colors.red),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '+${goal.pontos}',
                          style: TextStyle(
                            color: HexColor('#617188'),
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0.sp,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Icon(
                          FontAwesomeIcons.trophy,
                          size: 23.r,
                          color: HexColor('#617188'),
                        ),
                        Spacer(),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'R\$:',
                                style: TextStyle(
                                  color: HexColor('#b0b4c0'),
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: goal.value.toString(),
                                style: TextStyle(
                                  color: HexColor('#b0b4c0'),
                                  fontSize: 24.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    goal.active
                        ? Text(
                            'Conseguirá comprar em: 12/11/2021',
                            style: TextStyle(
                              color: HexColor('#617188'),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : SizedBox(
                            height: 10.h,
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (goal.avatar != '')
          Positioned(
            top: 15.h,
            left: 0.r,
            child: Container(
              height: 110.r,
              width: 110.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0.r),
                child: Card(
                  child: CachedNetworkImage(
                    imageUrl: goal.avatar!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
