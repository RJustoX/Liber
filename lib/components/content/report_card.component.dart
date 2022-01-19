import 'package:nicotine/components/content/content_card.component.dart';
import 'package:nicotine/models/_index.dart';

class ReportCardComponent extends ContentCardComponent {
  ReportCardComponent(
    final ReportModel report,
    final ReasonModel reason,
  ) : super(
          isTip: false,
          content: report.content,
          likes: report.likes,
          autor: report.user!.nickname,
          title: report.title,
          avatar: report.user!.avatar!,
          reason: reason,
        );
}
