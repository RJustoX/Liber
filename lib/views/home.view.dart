import 'package:flutter/material.dart';
import 'package:nicotine/components/home/feature_card.component.dart';
import 'package:nicotine/controllers/home.controller.dart';
import 'package:nicotine/utils/app_colors.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic>? books;
  List<Map<String, String>> dataMap = [
    {
      'value': '27',
      'desc': 'Dias',
    },
    {
      'value': 'R\$: 134:00',
      'desc': 'Economizados',
    },
    {
      'value': '2',
      'desc': 'Metas ativas',
    },
  ];
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leadingWidth: 65,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Rafael Justo'),
            Text('250'),
          ],
        ),
        actions: <Widget>[
          CircleAvatar(
            child: Icon(
              Icons.smoke_free,
              size: 28,
            ),
          ),
          Icon(
            Icons.notifications,
            size: 28,
          ),
          SizedBox(
            width: 15.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 110,
              width: double.maxFinite,
              color: AppColors.backgroundColor,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 30.0),
                itemCount: dataMap.length,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    color: AppColors.secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            dataMap[index]['value']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            dataMap[index]['desc']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      'Bom dia Rafael, mais um dia livre do vicio!',
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ...buildFeatures(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildFeatures() {
    List<Map<String, dynamic>> data = _homeController.getFeatures();
    return List<Widget>.generate(
      data.length,
      (int index) {
        return Column(
          children: <Widget>[
            FeatureCardComponent(
              data[index]['icon'],
              data[index]['title'],
              data[index]['desc'],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        );
      },
    );
  }
}
