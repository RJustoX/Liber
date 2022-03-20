import 'package:nicotine/components/content/content_card.component.dart';
import 'package:nicotine/controllers/content.controller.dart';
import 'package:nicotine/models/_index.dart';

// ignore: must_be_immutable
class ReportCardComponent extends ContentCardComponent {
  ReportCardComponent(
    final int userId,
    final ReportModel report,
    final ReasonModel reason,
    final ContentController controller,
  ) : super(
          isTip: false,
          content: report.content,
          likes: report.likes,
          liked: report.liked,
          autor: report.user!.nickname,
          title: report.title,
          avatar: report.user!.avatar!,
          reason: reason,
          isOwner: report.isOwner,
          controller: controller,
          data: {
            'userId': userId,
            'contentId': report.id,
            'vicioId': report.idVicio,
          },
          report: report,
        );
}
