import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/components/content/category_card.component.dart';
import 'package:nicotine/components/content/reason_card.component.dart';
import 'package:nicotine/components/content/report_card.component.dart';
import 'package:nicotine/components/content/tip_card.component.dart';
import 'package:nicotine/components/shared/vicio_avatar.component.dart';
import 'package:nicotine/controllers/content.controller.dart';
import 'package:nicotine/models/_index.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/toast.util.dart';
import 'package:nicotine/views/content/new_content.view.dart';
import 'package:provider/provider.dart';

class ContentView extends StatefulWidget {
  const ContentView();

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ContentController? _controller;
  late UserStore _uStore;
  late VicioStore _vStore;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    _uStore = Provider.of<UserStore>(context);
    _vStore = Provider.of<VicioStore>(context);
    _controller ??= ContentController();
    super.didChangeDependencies();

    _initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Conteúdos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.sp,
          ),
        ),
        actions: <Widget>[
          VicioAvatarComponent(_vStore.vicio!),
          SizedBox(
            width: 20.0.w,
          )
        ],
        bottom: TabBarComponent(
          controller: _tabController,
          tabs: ['Relatos', 'Dicas'],
        ),
      ),
      body: _controller!.isLoading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                reportsView(),
                tipsView(),
              ],
            ),
      floatingActionButton: SpeedDial(
        backgroundColor: AppColors.primaryColor,
        icon: Icons.add,
        spaceBetweenChildren: 10.0,
        children: <SpeedDialChild>[
          SpeedDialChild(
            child: Icon(Icons.assignment),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            label: 'Criar Relato',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewContentView(
                  isTip: false,
                  callback: _initialFetch,
                ),
              ),
            ),
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.lightbulb),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            label: 'Criar dica',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewContentView(
                  isTip: true,
                  callback: _initialFetch,
                ),
              ),
            ),
          ),
        ],
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
    );
  }

  Widget tipsView() {
    return _controller!.tips.isEmpty
        ? Column(
            children: <Widget>[
              buildCategories(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.2.sh),
                child: Center(
                  child: Text('Sem dicas'),
                ),
              )
            ],
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildCategories(),
                ...buildTipFeed(
                  true,
                  _controller!.tips,
                ),
                SizedBox(
                  height: 85.h,
                ),
              ],
            ),
          );
  }

  Widget reportsView() {
    return _controller!.reasons.isEmpty
        ? Column(
            children: <Widget>[
              buildReasons(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.2.sh),
                child: Center(
                  child: Text('Sem relatos'),
                ),
              )
            ],
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildReasons(),
                ...buildReportFeed(
                  false,
                  _controller!.reports,
                ),
                SizedBox(
                  height: 85.h,
                ),
              ],
            ),
          );
  }

  Widget buildReasons() {
    return Container(
      height: 200.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        itemCount: _controller!.reasons.length,
        separatorBuilder: (context, index) => SizedBox(
          width: 15.0,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              _controller!.setReasonFilter(_controller!.reasons[index]);
            });
          },
          child: ReasonCardComponent(
            reason: _controller!.reasons[index],
          ),
        ),
      ),
    );
  }

  List<Widget> buildReportFeed(bool isTip, List<dynamic> reports) {
    List<Widget> result = [];
    reports = _controller!.getFilterReports(reports);
    for (int i = 0; i < reports.length; i++) {
      ReasonModel reason = _controller!.getReason(reports[i].idReason);
      result.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: ReportCardComponent(
          reports[i],
          reason,
        ),
      ));
    }
    return result;
  }

  Widget buildCategories() {
    return Container(
      height: 200.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
        itemCount: _controller!.categories.length,
        separatorBuilder: (context, index) => SizedBox(
          width: 15.0,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
            setState(() {
              _controller!.removeFilters();
              _controller!.isLoading = true;
              _controller!.categories[index].selected = true;
              _initialFetch(isFilter: true);
            });
          },
          child: CategoryCardComponent(
            category: _controller!.categories[index],
          ),
        ),
      ),
    );
  }

  List<Widget> buildTipFeed(bool isTip, List<dynamic> tips) {
    List<Widget> result = [];
    for (int i = 0; i < tips.length; i++) {
      CategoryModel category = _controller!.getCategory(tips[i].idCategory);
      result.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: TipCardComponent(tips[i], category),
      ));
    }
    return result;
  }

  Future<void> _initialFetch({bool isFilter = false}) async {
    if (_controller!.isLoading) {
      if (!isFilter) {
        try {
          await _controller!.fetchCategories(_vStore.vicio!.id);
        } catch (error) {
          ToastUtil.error(_controller!.message!);
        }

        try {
          await _controller!.fetchReasons(_vStore.vicio!.id);
        } catch (error) {
          ToastUtil.error(_controller!.message!);
        }
      }

      try {
        await _controller!.fetchReports(_vStore.vicio!.id);
      } catch (error) {
        ToastUtil.error(_controller!.message!);
      }

      try {
        await _controller!.fetchTips(_vStore.vicio!.id, categoryId: 1);
      } catch (error) {
        ToastUtil.error('Não foi possivel carregar as dicas');
      }

      // if (_controller!.message != null && _controller!.message != '')
      //   ToastUtil.error(_controller!.message!);

      if (mounted) setState(() => _controller!.isLoading = false);
    }
  }
}
