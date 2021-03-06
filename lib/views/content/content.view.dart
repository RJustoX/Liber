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
                if (_controller!.filtering)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.2.sh),
                    child: CircularProgressIndicator(),
                  )
                else
                  ...buildTipFeed(
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
                if (_controller!.filtering)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.2.sh),
                    child: CircularProgressIndicator(),
                  )
                else
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
              setState(() {
                _controller!.setReasonFilter(_controller!.reasons[index]);
                _controller!.filtering = true;
                _initialFetch();
              });
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

    if (reports.isEmpty) {
      result = [
        SizedBox(
          height: 0.2.sh,
        ),
        Center(child: Text('Sem relatos'))
      ];
    }

    for (int i = 0; i < reports.length; i++) {
      ReasonModel reason = _controller!.getReason(reports[i].idReason);
      result.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: ReportCardComponent(
          _uStore.user!.id,
          reports[i],
          reason,
          _controller!,
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
          onTap: () {
            setState(() {
              _controller!.setCategoryFilter(_controller!.categories[index]);
              _controller!.filtering = true;
              _initialFetch();
            });
          },
          child: CategoryCardComponent(
            category: _controller!.categories[index],
          ),
        ),
      ),
    );
  }

  List<Widget> buildTipFeed(List<dynamic> tips) {
    List<Widget> result = [];
    tips = _controller!.getFilterTips(tips);

    if (tips.isEmpty) {
      result = [
        SizedBox(
          height: 0.2.sh,
        ),
        Center(child: Text('Sem dicas'))
      ];
    }

    for (int i = 0; i < tips.length; i++) {
      CategoryModel category = _controller!.getCategory(tips[i].idCategory);
      result.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: TipCardComponent(
            _uStore.user!.id,
            tips[i],
            category,
            _controller!,
          ),
        ),
      );
    }
    return result;
  }

  Future<void> _initialFetch() async {
    if (_controller!.isLoading) {
      if (!_controller!.filtering) {
        try {
          await _controller!.fetchCategories(_vStore.vicio!.id);
        } catch (error) {
          ToastUtil.error(_controller!.message!);
        }

        try {
          await _controller!.fetchReasons(_uStore.user!.id, _vStore.vicio!.id);
        } catch (error) {
          ToastUtil.error(_controller!.message!);
        }
      }
    }

    try {
      await _controller!.fetchReports(_uStore.user!.id, _vStore.vicio!.id);
    } catch (error) {
      ToastUtil.error('Não foi possivel carregar os relatos');
    }

    try {
      await _controller!.fetchTips(_uStore.user!.id, _vStore.vicio!.id, categoryId: 1);
    } catch (error) {
      ToastUtil.error('Não foi possivel carregar as dicas');
    }

    // if (_controller!.message != null && _controller!.message != '')
    //   ToastUtil.error(_controller!.message!);

    if (mounted) {
      setState(() {
        _controller!.isLoading = false;
        _controller!.filtering = false;
      });
    }
  }
}
