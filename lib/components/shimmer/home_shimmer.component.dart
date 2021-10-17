import 'package:flutter/material.dart';
import 'package:nicotine/components/home/feature_card.component.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerComponent extends StatelessWidget {
  const HomeShimmerComponent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 1.0, bottom: 5.0),
          child: Shimmer.fromColors(
            baseColor: Colors.blueGrey[100]!,
            highlightColor: Colors.blueGrey[50]!,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.blueGrey[100]!,
              highlightColor: Colors.blueGrey[50]!,
              child: Container(
                height: 20.h,
                width: 120.w,
                color: Colors.white,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.blueGrey[100]!,
              highlightColor: Colors.blueGrey[50]!,
              child: Container(
                height: 20.h,
                width: 80.w,
                color: Colors.white,
              ),
            )
          ],
        ),
        actions: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.blueGrey[100]!,
            highlightColor: Colors.blueGrey[50]!,
            child: CircleAvatar(
              radius: 16,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Shimmer.fromColors(
            baseColor: Colors.blueGrey[100]!,
            highlightColor: Colors.blueGrey[50]!,
            child: Icon(
              Icons.notifications_outlined,
              size: 28,
            ),
          ),
          SizedBox(
            width: 15.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 150.h,
              width: double.maxFinite,
              color: AppColors.backgroundColor,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 35.0.w),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                  child: Shimmer.fromColors(
                    baseColor: Colors.blueGrey[100]!,
                    highlightColor: Colors.blueGrey[50]!,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      color: AppColors.secondaryColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Place',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0.sp,
                              ),
                            ),
                            Text(
                              'Place',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 22.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.blueGrey[100]!,
                      highlightColor: Colors.blueGrey[50]!,
                      child: Text(
                        'Seus dados estão sendo carregados!',
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 22.0.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ...buildFeatures(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildFeatures() {
    return List<Widget>.generate(
      3,
      (int index) {
        return Column(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.blueGrey[100]!,
              highlightColor: Colors.blueGrey[50]!,
              child: FeatureCardComponent(
                'assets/goalIcon.png',
                'Aham uque crock',
                'bah',
              ),
            ),
            SizedBox(
              height: 0.05.sh,
            ),
          ],
        );
      },
    );
  }
}
