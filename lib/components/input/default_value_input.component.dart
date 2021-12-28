import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultValueInputComponent extends StatelessWidget {
  const DefaultValueInputComponent({
    required this.title,
    this.onSaved,
  });

  final Function(String?)? onSaved;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: HexColor('#B0B4C0'),
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: HexColor('#B0B4C0'),
              fontSize: 18.0.sp,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor('#B0B4C0'),
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor('#B0B4C0'),
                ),
              ),
              prefix: Text(
                'R\$: ',
                style: TextStyle(
                  color: HexColor('#B0B4C0'),
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              hintText: '0,00',
              hintStyle: TextStyle(
                color: HexColor('#B0B4C0'),
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
