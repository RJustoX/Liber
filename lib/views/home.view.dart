import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/card.component.dart';

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
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(60),
                ),
                color: HexColor('#677DB7'),
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
