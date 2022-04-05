import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/components/shared/dialog.component.dart';
import 'package:nicotine/controllers/goal.controller.dart';
import 'package:nicotine/models/goal.model.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/home/new_goal.view.dart';

class GoalDialog extends StatelessWidget {
  const GoalDialog({
    required this.goal,
    required this.callback,
    required this.controller,
  });

  final GoalModel goal;
  final VoidCallback callback;
  final GoalController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0.r),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return DialogComponent(
                                content: 'Gostaria de excluir esta meta?',
                                confirmAction: () async {
                                  await controller.deleteGoal(goal.id);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  ToastUtil.success(controller.message);
                                  callback();
                                },
                              );
                            });
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        size: 35.r,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewGoalView(
                              goal: goal,
                              callback: callback,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 35.r,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'R\$: ${goal.value}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  child: Text(
                    goal.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (goal.description != null)
                  Text(
                    goal.description!,
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 15.h),
                  child: Text(
                    '',
                    style: TextStyle(
                      color: AppColors.primaryFontColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size(0.3.sw, 50.h),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.r),
                              topLeft: Radius.circular(15.r),
                            ),
                          ),
                        ),
                        child: Text(
                          goal.active ? 'Desativar' : 'Ativar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        width: 1,
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size(0.3.sw, 50.h),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                          ),
                        ),
                        child: Text(
                          'Concluir',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (goal.avatar != '')
            Positioned(
              top: 5.h,
              left: (0.5.sw - 105.r),
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Container(
                  height: 105.r,
                  width: 105.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0.r),
                    child: CachedNetworkImage(
                      imageUrl: goal.avatar!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
