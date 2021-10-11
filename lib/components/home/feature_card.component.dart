import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/utils/app_colors.dart';

class FeatureCardComponent extends StatelessWidget {
  const FeatureCardComponent(
    this.icon,
    this.title,
    this.desc,
  );

  final String icon;
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(55.0, 15.0, 20.0, 20.0),
          margin: EdgeInsets.only(left: 40.0),
          height: MediaQuery.of(context).size.height * 0.15,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 7.5,
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          heightFactor: 1.5,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: HexColor('#FCE0A2'),
            child: Image.asset(icon),
          ),
        ),
      ],
    );
  }
}
