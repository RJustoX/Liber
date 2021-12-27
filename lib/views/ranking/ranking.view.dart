import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/components/shared/vicio_avatar.component.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
    _vStore = Provider.of<VicioStore>(context);
    super.didChangeDependencies();
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
            child: ListView.separated(
              itemCount: 15,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0.0, 15.h, 20.w, 15.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0.w),
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Text(
                        'Rafael Justo',
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Icon(
                        FontAwesomeIcons.trophy,
                        color: HexColor('#6A7188'),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        '250',
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#6A7188'),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
