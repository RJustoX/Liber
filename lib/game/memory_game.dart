// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'game.constants.dart';
// import 'game_model.dart';

// class GamePage extends StatelessWidget {
//   final GamePlay gamePlay;

//   const GamePage({Key? key, required this.gamePlay}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final controller = Provider.of<GameController>(context);
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text('tico'), //GameScore(modo: gamePlay.modo),
//       ),
//       // body: const FeedbackGame(resultado: Resultado.eliminado),

//       body: Observer(
//         builder: (_) {
//           if (controller.venceu) {
//             return const FeedbackGame(resultado: Resultado.aprovado);
//           } else if (controller.perdeu) {
//             return const FeedbackGame(resultado: Resultado.eliminado);
//           } else {
//             return Center(
//               child: GridView.count(
//                 shrinkWrap: true,
//                 crossAxisCount: GameSettings.gameBoardAxisCount(gamePlay.nivel),
//                 mainAxisSpacing: 15,
//                 crossAxisSpacing: 15,
//                 padding: const EdgeInsets.all(24),
//                 children: controller.gameCards
//                     .map(
//                       (GameOpcao go) => CardGame(modo: gamePlay.modo, gameOpcao: go),
//                     )
//                     .toList(),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
