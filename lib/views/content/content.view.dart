import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentView extends StatefulWidget {
  const ContentView();

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Conteúdos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp),
        ),
        actions: <Widget>[
          CircleAvatar(
            child: Image.asset('assets/vicioLogo/tabagismoLogo.png'),
            radius: 20.r,
          ),
          SizedBox(
            width: 20.0.w,
          )
        ],
        bottom: TabBarComponent(
          controller: _tabController,
          tabs: ['Relatos', 'Dicas'],
        ),
      ),
      body: Center(
        child: Text(
          'Em Breve!',
          style: TextStyle(
            color: AppColors.primaryFontColor,
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
