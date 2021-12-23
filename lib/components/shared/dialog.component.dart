import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogComponent extends StatefulWidget {
  const DialogComponent({
    required this.content,
    this.title,
    this.cancelAction,
    this.confirmAction,
    this.actions,
    this.cancelText,
    this.confirmText,
  });

  final String? title, cancelText, confirmText;
  final String content;
  final Function? cancelAction, confirmAction;
  final List<Widget>? actions;

  @override
  _DialogComponentState createState() => _DialogComponentState();
}

class _DialogComponentState extends State<DialogComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: widget.title != null
          ? Text(
              widget.title!,
              style: TextStyle(
                color: HexColor('#3C3F4C'),
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            )
          : null,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      content: Container(
        width: double.maxFinite,
        child: Text(
          widget.content,
          style: TextStyle(
            color: HexColor('#3C3F4C'),
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
          softWrap: true,
        ),
      ),
      actions: widget.actions ?? _defaultActions(),
    );
  }

  List<Widget> _defaultActions() {
    return <Widget>[
      TextButton(
        child: Text(
          widget.cancelText?.toUpperCase() ?? 'CANCELAR',
          style: TextStyle(
            color: HexColor('#6A6F86'),
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          if (widget.cancelAction == null) {
            return Navigator.of(context).pop(false);
          } else {
            return widget.cancelAction!();
          }
        },
      ),
      TextButton(
        child: Text(
          widget.confirmText?.toUpperCase() ?? 'CONFIRMAR',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          if (widget.confirmAction == null) {
            return Navigator.of(context).pop(true);
          } else {
            return widget.confirmAction!();
          }
        },
      ),
    ];
  }
}
