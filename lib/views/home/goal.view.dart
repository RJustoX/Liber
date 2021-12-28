import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/goal/goal_card.component.dart';
import 'package:nicotine/controllers/goal.controller.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/home/new_goal.view.dart';
import 'package:provider/provider.dart';

class GoalView extends StatefulWidget {
  const GoalView();

  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  late UserStore _uStore;
  GoalController? _controller;

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
    _controller ??= GoalController();
    super.didChangeDependencies();
    _initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.w),
                  color: AppColors.primaryColor,
                  height: 260.h,
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 60.r,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35.w, top: 15.h),
                        child: Text(
                          'Metas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 36.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: _controller!.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _controller!.goals != null && _controller!.goals!.isEmpty
                          ? Center(
                              child: Text('Sem metas cadastradas'),
                            )
                          : Container(
                              color: AppColors.backgroundColor,
                              child: ListView.separated(
                                padding: EdgeInsets.fromLTRB(30.w, 120.h, 30.w, 100.0.h),
                                itemCount: _controller!.goals!.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20.h,
                                ),
                                itemBuilder: (context, index) {
                                  return GoalCardComponent(
                                    _controller!.goals![index],
                                    _initialFetch,
                                    _controller!,
                                  );
                                },
                              ),
                            ),
                )
              ],
            ),
            Positioned(
              top: 160.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.5.w),
                child: Container(
                  height: 200.h,
                  width: 455.w,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(25.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.moneyBillWave,
                                size: 50.r,
                                color: HexColor('#b0b4c0'),
                              ),
                              Text(
                                'Economia diária',
                                style: TextStyle(
                                  color: HexColor('#617188'),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.5),
                              Text(
                                'R\$: 7,50',
                                style: TextStyle(
                                  color: HexColor('#617188'),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.piggyBank,
                                size: 50.r,
                                color: HexColor('#b0b4c0'),
                              ),
                              Text(
                                'Total economizado',
                                style: TextStyle(
                                  color: HexColor('#617188'),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.5),
                              Text(
                                'R\$: 15,00',
                                style: TextStyle(
                                  color: HexColor('#617188'),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.check,
                                size: 50.r,
                                color: HexColor('#b0b4c0'),
                              ),
                              Text(
                                'Metas concluidas',
                                style: TextStyle(
                                  color: HexColor('#617188'),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2.5),
                              Text(
                                '0',
                                style: TextStyle(
                                  color: HexColor('#617188'),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewGoalView(
                  callback: _initialFetch,
                ),
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 45.r,
          ),
        ),
      ),
    );
  }

  Future<void> _initialFetch() async {
    await _controller!.fetchGoals(_uStore.user!.id);
    if (!_controller!.message.contains('sucesso')) ToastUtil.success(_controller!.message);

    if (mounted) setState(() => _controller!.isLoading = false);
  }
}
