import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/controllers/main.controller.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/content/content.view.dart';
import 'package:nicotine/views/content/groups.view.dart';
import 'package:nicotine/views/home/home.view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends StatefulWidget {
  const MainView();

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainController? _controller;

  void didChangeDependencies() async {
    super.didChangeDependencies();
    _controller ??= MainController();
    _initialFetch();
  }

  int _currentIndex = 0;

  List<Widget> tabs = [
    HomeView(),
    ContentView(),
    GroupsView(),
    Center(
      child: Text('Tela de ranking'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller!.loading
          ? Container(
              height: 1.sh,
              width: 1.sw,
              color: AppColors.primaryColor,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.backgroundColor,
                ),
              ),
            )
          : tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 18.0.sp,
        unselectedFontSize: 16.0.sp,
        selectedIconTheme: IconThemeData(
          size: 40.r,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.primaryColor,
          size: 35.r,
        ),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Conteúdos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Grupos',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.medal),
            label: 'Ranking',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            print(_controller!.getUser().name);
          });
        },
      ),
    );
  }

  Future<void> _initialFetch() async {
    try {
      await _controller!.fetchUser();
    } catch (error) {
      ToastUtil.error(error.toString());
      print(error.toString());
    }

    if (mounted) setState(() => _controller!.loading = false);
  }
}
