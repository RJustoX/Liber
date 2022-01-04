import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/components/ranking/ranking_tile.component.dart';
import 'package:nicotine/components/shared/vicio_avatar.component.dart';
import 'package:nicotine/controllers/ranking.controller.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:provider/provider.dart';

class RankingView extends StatefulWidget {
  const RankingView();

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late UserStore _uStore;
  late VicioStore _vStore;
  late RankingController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    _controller = RankingController();
    _uStore = Provider.of<UserStore>(context);
    _vStore = Provider.of<VicioStore>(context);
    super.didChangeDependencies();
    _initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Ranking',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp),
        ),
        actions: <Widget>[
          VicioAvatarComponent(_vStore.vicio!),
          SizedBox(
            width: 20.0.w,
          )
        ],
        bottom: TabBarComponent(
          controller: _tabController,
          tabs: ['Mensal', 'Anual', 'Total'],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.secondaryColor,
            height: 0.3.sh,
            child: Center(
              child: Text(
                'Em Breve!',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Flexible(
            child: _controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: _controller.allTimeUsers.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      return RankingTileComponent(
                        index: index,
                        user: _controller.allTimeUsers[index],
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Future<void> _initialFetch() async {
    await _controller.fetchAllTime(_vStore.vicio!.id);
    ToastUtil.success(_controller.message);
    if (mounted) setState(() => _controller.isLoading = false);
  }
}
