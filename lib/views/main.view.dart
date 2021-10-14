import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/views/home/home.view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends StatefulWidget {
  const MainView();

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  int _currentIndex = 0;

  List<Widget> tabs = [
    HomeView(),
    Center(
      child: Text('Tela de conteudos'),
    ),
    Center(
      child: Text('Tela dos grupos'),
    ),
    Center(
      child: Text('Tela de ranking'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
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
          });
        },
      ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.home,
      //           color: AppColors.secondaryColor,
      //           size: 45.r,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.assignment,
      //           color: AppColors.secondaryColor,
      //           size: 45.r,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           Icons.group,
      //           color: AppColors.secondaryColor,
      //           size: 45.r,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           FontAwesomeIcons.medal,
      //           color: AppColors.secondaryColor,
      //           size: 30.r,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
