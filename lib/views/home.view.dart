import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#1B2A41'),
      body: Column(
        children: [
          Container(
            color: HexColor('#1B2A41'),
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(60),
                ),
                color: HexColor('#677DB7'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
