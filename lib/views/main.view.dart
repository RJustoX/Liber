import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/controllers/main.controller.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/content/content.view.dart';
import 'package:nicotine/views/groups/groups.view.dart';
import 'package:nicotine/views/home/home.view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/views/quest.view.dart';
import 'package:nicotine/views/ranking/ranking.view.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView();

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late UserStore _uStore;
  late VicioStore _vStore;
  MainController? _controller;

  void didChangeDependencies() async {
    super.didChangeDependencies();
    _uStore = Provider.of<UserStore>(context);
    _vStore = Provider.of<VicioStore>(context);
    _controller ??= MainController(_uStore, _vStore);
    _initialFetch();
  }

  int _currentIndex = 0;

  List<Widget> tabs = [
    HomeView(),
    ContentView(),
    GroupsView(),
    RankingView(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestView()));
        },
        backgroundColor: AppColors.secondaryColor,
        child: Icon(Icons.forum),
        tooltip: 'Questionário',
      ),
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
