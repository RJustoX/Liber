import 'package:nicotine/components/content/content_card.component.dart';
import 'package:nicotine/controllers/content.controller.dart';
import 'package:nicotine/models/category.model.dart';
import 'package:nicotine/models/tip.model.dart';

// ignore: must_be_immutable
class TipCardComponent extends ContentCardComponent {
  TipCardComponent(
    final int userId,
    final TipModel tip,
    final CategoryModel category,
    final ContentController controller,
  ) : super(
            isTip: true,
            content: tip.content,
            likes: tip.likes,
            liked: tip.liked,
            autor: tip.user!.nickname,
            avatar: tip.user!.avatar!,
            isOwner: tip.isOwner,
            category: category,
            controller: controller,
            data: {
              'userId': userId,
              'contentId': tip.id,
              'vicioId': tip.idVicio,
            });
}
