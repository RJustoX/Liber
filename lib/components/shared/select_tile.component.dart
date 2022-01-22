import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/utils/app_colors.dart';

class SelectTileComponent extends StatelessWidget {
  const SelectTileComponent({
    required this.title,
    this.hint,
    this.content,
    this.padding,
    this.onTap,
    this.inputType = false,
    this.loading = false,
    this.showIcon = true,
    this.disabled = false,
  });

  final String title;
  final String? hint;
  final Widget? content;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool inputType;
  final bool loading;
  final bool showIcon;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading || disabled ? () {} : onTap ?? () {},
      child: Ink(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: HexColor('#3C3F4C').withOpacity(disabled ? 0.5 : 1.0),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!disabled && showIcon)
                  Icon(
                    inputType ? Icons.edit : FontAwesomeIcons.chevronDown,
                    color: HexColor('#B7B9C7'),
                    size: 22,
                  ),
              ],
            ),
            getContent(),
          ],
        ),
      ),
    );
  }

  Widget getContent() {
    late Widget _content;

    if (loading) {
      _content = Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: CircularProgressIndicator(),
      );
    } else if (content != null) {
      _content = disabled
          ? Opacity(
              opacity: 0.5,
              child: content,
            )
          : content!;
    } else {
      _content = Text(
        (hint != '' ? hint : null) ??
            (inputType ? 'Toque para adicionar' : 'Toque para selecionar'),
        style: TextStyle(
          color: HexColor((hint != null && hint != '') ? '#6A6F86' : '#304FFE')
              .withOpacity(disabled ? 0.5 : 1.0),
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return _content;
  }
}
