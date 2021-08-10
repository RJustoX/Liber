import 'package:flutter/material.dart';
import 'package:nicotine/components/card.component.dart';
import 'package:nicotine/utils/app_colors.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        children: [
          Container(
            color: AppColors.secondaryColor,
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          Expanded(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(60),
                ),
                color: AppColors.primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Bom dia Rafael, mais um dia sem Nicotina!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    Flexible(
                      child: ListView.separated(
                        separatorBuilder: (_, int index) {
                          print(index);
                          return SizedBox(height: 30);
                        },
                        itemCount: 3,
                        itemBuilder: (_, int index) {
                          return CardComponent();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
