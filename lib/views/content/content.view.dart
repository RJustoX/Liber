import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/tab_bar.component.dart';
import 'package:nicotine/components/content/category_card.component.dart';
import 'package:nicotine/components/content/content_card.component.dart';
import 'package:nicotine/controllers/content.controller.dart';
import 'package:nicotine/stores/user.store.dart';
import 'package:nicotine/stores/vicio.store.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicotine/utils/toast.util.dart';
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
        // actions: <Widget>[
        //   VicioAvatarComponent(_vStore.vicio!),
        //   SizedBox(
        //     width: 20.0.w,
        //   )
        // ],
        bottom: TabBarComponent(
          controller: _tabController,
          tabs: ['Relatos', 'Dicas'],
        ),
      ),
      body: _controller!.isLoading
          ? CircularProgressIndicator()
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                reportsView(),
                tipsView(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
    );
  }

  Widget tipsView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildCategories(),
          ...buildFeed(true),
        ],
      ),
    );
  }

  Widget reportsView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildCategories(),
          ...buildFeed(false),
        ],
      ),
    );
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
        itemBuilder: (context, index) => CategoryCardComponent(
          category: _controller!.categories[index],
        ),
      ),
    );
  }

  List<Widget> buildFeed(bool isTip) {
    List<Widget> result = [];
    for (int i = 0; i <= 5; i++) {
      result.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: ContentCardComponent(isTip: isTip),
      ));
    }
    return result;
  }

  Future<void> _initialFetch() async {
    await _controller!.fetchCategories(_vStore.vicio!.id);

    if (_controller!.message != null && _controller!.message != '')
      ToastUtil.error(_controller!.message!);

    if (mounted) setState(() => _controller!.isLoading = false);
  }
}
