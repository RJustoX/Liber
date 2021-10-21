import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class GoalCardComponent extends StatelessWidget {
  const GoalCardComponent();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          height: 150.h,
          margin: EdgeInsets.only(left: 30.r),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0.r)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(80.w, 20.h, 20.h, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Tênis de marca',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(Icons.circle, color: Colors.green),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '+250',
                        style: TextStyle(
                          color: HexColor('#617188'),
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0.sp,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Icon(
                        FontAwesomeIcons.trophy,
                        size: 23.r,
                        color: HexColor('#617188'),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'R\$:',
                              style: TextStyle(
                                color: HexColor('#b0b4c0'),
                                fontSize: 18.0.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: ' 350,00',
                              style: TextStyle(
                                color: HexColor('#b0b4c0'),
                                fontSize: 24.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Conseguirá comprar em: 12/11/2021',
                    style: TextStyle(
                      color: HexColor('#617188'),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 15.h,
          left: 0.r,
          child: Container(
            height: 110.r,
            width: 110.r,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0.r),
              ),
              child: Image.network(
                'https://cdnv2.moovin.com.br/belinhacalcados/imagens/produtos/det/tenis-nike-843895001-sb-check-solar-d880ea4a6c2100f909a78778c8407bbe.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
