import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/utils/app_colors.dart';

class LogoComponent extends StatefulWidget {
  LogoComponent({
    this.size = 120,
  });

  final double size;

  @override
  _LogoComponentState createState() => _LogoComponentState();
}

class _LogoComponentState extends State<LogoComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: AppColors.secondaryColor,
              ),
            ),
            Positioned(
              top: 35,
              right: -15,
              child: Text(
                'Nicotine',
                style: TextStyle(
                  color: HexColor('#F4F5F5'),
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
