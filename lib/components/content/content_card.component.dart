import 'package:flutter/material.dart';

class ContentCardComponent extends StatelessWidget {
  const ContentCardComponent();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: Card(
        child: Column(
          children: <Widget>[
            Text('user'),
            Text('conteudo'),
            Divider(),
            Row(
              children: <Widget>[
                Icon(Icons.thumbs_up_down),
                Icon(Icons.thumbs_up_down),
                Spacer(),
                Icon(Icons.menu),
              ],
            )
          ],
        ),
      ),
    );
  }
}
