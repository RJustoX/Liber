import 'package:flutter/material.dart';
import 'package:nicotine/components/ranking/ranking_trinity_avatar.component.dart';
import 'package:nicotine/models/user.model.dart';

class RankingTrinityComponent extends StatelessWidget {
  const RankingTrinityComponent(
    this.users,
  );
  final List<UserRankingModel> users;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RankingTrinityAvatarComponent(
            user: users[1],
            position: 2,
          ),
          RankingTrinityAvatarComponent(
            user: users[0],
            position: 1,
          ),
          RankingTrinityAvatarComponent(
            user: users[2],
            position: 3,
          ),
        ],
      ),
    );
  }
}
