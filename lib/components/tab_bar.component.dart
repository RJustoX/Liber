import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const TabBarComponent({
    required this.tabs,
    required this.controller,
  });
  final List<String> tabs;
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.white,
      labelColor: Colors.white,
      indicatorWeight: 3.0.h,
      labelStyle: TextStyle(
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      indicatorColor: Colors.white,
      tabs: buildTabs(tabs),
    );
  }

  @override
  Size get preferredSize => Size(0.0, 50.0.h);
}

List<Tab> buildTabs(List<String> tabs) {
  final List<Tab> result = <Tab>[];
  for (String tab in tabs) {
    result.add(Tab(text: tab));
  }
  return result;
}
