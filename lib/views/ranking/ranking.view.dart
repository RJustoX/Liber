import 'package:flutter/material.dart';
import 'package:nicotine/components/ranking/ranking_tile.component.dart';
import 'package:nicotine/components/ranking/ranking_trinity.component.dart';
import 'package:nicotine/components/shared/vicio_avatar.component.dart';
import 'package:nicotine/controllers/ranking.controller.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RankingView extends StatefulWidget {
  const RankingView();

  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> with AutomaticKeepAliveClientMixin {
  late VicioStore _vStore;
  late RankingController _controller;

  @override
  void didChangeDependencies() {
    _controller = RankingController();
    _vStore = Provider.of<VicioStore>(context);
    _initialFetch();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: AppColors.secondaryColor,
            height: 0.3.sh,
            child: Center(
              child: _controller.isLoading
                  ? Text(
                      'Carregando...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                      ),
                    )
                  : RankingTrinityComponent(
                      _controller.trinityUsers,
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
    if (mounted) setState(() => _controller.isLoading = false);
  }

  @override
  bool get wantKeepAlive => true;
}
