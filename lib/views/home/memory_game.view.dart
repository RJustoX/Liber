import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemoryGameView extends StatefulWidget {
  const MemoryGameView({Key? key}) : super(key: key);

  @override
  _MemoryGameViewState createState() => _MemoryGameViewState();
}

class _MemoryGameViewState extends State<MemoryGameView> {
  TextStyle whiteText = TextStyle(color: Colors.white);
  bool hideTest = false;
  Game _game = Game();

  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _game.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarComponent(
        context,
        title: 'Jogo da memória',
        centerTitle: true,
        haveLeading: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24.0,
          ),
          Center(
            child: buildInfoCard('Tempo:', '50 seg', context),
          ),
          SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildInfoCard("Tentativas", "$tries", context),
              buildInfoCard("Pontução", "$score", context),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  itemCount: _game.gameImg!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_game.check);
                        setState(() {
                          _game.gameImg![index] = _game.iconList[index];
                          _game.check.add({index: _game.iconList[index]});
                          print(_game.check.first);
                        });
                        if (_game.check.length == 2) {
                          if (_game.check[0].values.first == _game.check[1].values.first) {
                            print("true");
                            //incrementing the score
                            score += 100;
                            _game.check.clear();
                          } else {
                            print("false");

                            Future.delayed(Duration(milliseconds: 1000), () {
                              print(_game.gameColors);
                              setState(() {
                                _game.gameImg![_game.check[0].keys.first] = _game.baseCardIcon;
                                _game.gameImg![_game.check[1].keys.first] = _game.baseCardIcon;
                                tries++;
                                _game.check.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          _game.gameImg![index],
                          color: AppColors.primaryColor,
                          size: 45.r,
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  Widget buildInfoCard(String title, String info, BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              info,
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<IconData>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final IconData baseCardIcon = FontAwesomeIcons.question;

  List<IconData> iconList = [
    FontAwesomeIcons.frownOpen,
    FontAwesomeIcons.frownOpen,
    FontAwesomeIcons.angry,
    FontAwesomeIcons.angry,
    FontAwesomeIcons.sadTear,
    FontAwesomeIcons.sadTear,
    FontAwesomeIcons.flushed,
    FontAwesomeIcons.flushed,
    FontAwesomeIcons.frown,
    FontAwesomeIcons.frown,
    FontAwesomeIcons.grinTongue,
    FontAwesomeIcons.grinTongue,
    FontAwesomeIcons.mehBlank,
    FontAwesomeIcons.mehBlank,
    FontAwesomeIcons.smile,
    FontAwesomeIcons.smile,
  ];

  final int cardCount = 16;
  List<Map<int, IconData>> check = [];

  void start() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => baseCardIcon);
  }
}
