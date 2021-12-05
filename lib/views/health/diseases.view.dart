import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/utils/app_colors.dart';

class DiseasesView extends StatelessWidget {
  const DiseasesView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Badge(
            toAnimate: true,
            shape: BadgeShape.square,
            badgeColor: Colors.white,
            borderRadius: BorderRadius.circular(8),
            badgeContent: Text(
              'Estas são as principais doenças derivadas de seu vicío!',
              style: TextStyle(
                color: AppColors.primaryFontColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 10.0,
                    mainAxisExtent: 180,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  itemCount: 5,
                  itemBuilder: (_, int index) {
                    return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.coronavirus,
                                size: 60,
                                color: AppColors.primaryFontColor,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Impotencia sexual',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Casos:',
                                      style: TextStyle(
                                        color: AppColors.primaryFontColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '220M',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
