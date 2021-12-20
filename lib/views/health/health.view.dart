import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/views/health/diseases.view.dart';
import 'package:nicotine/views/progress/calendar.dialog.dart';

class HealthView extends StatefulWidget {
  const HealthView();

  @override
  _HealthViewState createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarComponent(
        context,
        title: 'Saúde',
        haveLeading: true,
        tabBar: TabBarComponent(
          controller: _tabController,
          tabs: ['Doenças', 'Motivos'],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          DiseasesView(),
          CalendarDialog(),
        ],
      ),
    );
  }
}
