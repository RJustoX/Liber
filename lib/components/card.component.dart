import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/utils/app_colors.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30, left: 50),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Titulo',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 10, 5),
                child: Text(
                  'Descrição do modulo, um breve resumo da funcionalidade!',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17 / 3,
          left: -0,
          child: Container(
            width: MediaQuery.of(context).size.height * 0.13,
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: BoxDecoration(
              color: HexColor('#90E3F4'),
              borderRadius: BorderRadius.circular(60),
            ),
          ),
        )
      ],
    );
  }
}
