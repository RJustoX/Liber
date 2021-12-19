import 'package:flutter/material.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/quest/quest_card.component.dart';
import 'package:nicotine/utils/app_colors.dart';

class QuestView extends StatelessWidget {
  const QuestView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: DefaultAppBarComponent(
        context,
        title: 'Questionário',
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: QuestCardComponent()),
        ],
      ),
    );
  }
}
