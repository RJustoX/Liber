import 'package:nicotine/components/content/content_card.component.dart';
import 'package:nicotine/models/category.model.dart';
import 'package:nicotine/models/tip.model.dart';

class TipCardComponent extends ContentCardComponent {
  TipCardComponent(
    final TipModel tip,
    final CategoryModel category,
  ) : super(
          isTip: true,
          content: tip.content,
          likes: tip.likes,
          autor: tip.user!.nickname,
          avatar: tip.user!.avatar!,
          category: category,
        );
}
