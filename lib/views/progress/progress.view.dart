import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/views/progress/calendar.dialog.dart';
import 'package:nicotine/views/progress/chart.dialog.dart';

class ProgressView extends StatefulWidget {
  const ProgressView();

  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> with SingleTickerProviderStateMixin {
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
        title: 'Acompanhamento',
        haveLeading: true,
        tabBar: TabBarComponent(
          controller: _tabController,
          tabs: ['Diário', 'Gráfico'],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CalendarDialog(),
          ChartDialog(),
        ],
      ),
    );
  }
}
