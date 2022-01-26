import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nicotine/components/appBar/default_appbar.component.dart';
import 'package:nicotine/components/bottom_buttons.component.dart';

class InputDialogComponent extends StatefulWidget {
  const InputDialogComponent({
    required this.title,
    required this.hint,
    this.value = '',
    this.obscureText = false,
    this.titleColor,
    this.confirmAction,
    this.confirmText,
    this.closeIcon = false,
  });

  final String title, hint;
  final String? value, confirmText;
  final bool obscureText, closeIcon;
  final Function()? confirmAction;
  final Color? titleColor;

  @override
  _InputDialogComponentState createState() => _InputDialogComponentState();
}

class _InputDialogComponentState extends State<InputDialogComponent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.value != null ? widget.value! : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarComponent(
        context,
        title: widget.title,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: double.maxFinite,
                child: TextField(
                  controller: _controller,
                  obscureText: widget.obscureText,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: HexColor('#3C3F4C'),
                      fontSize: 16.0,
                    ),
                    border: InputBorder.none,
                  ),
                  maxLines: 100,
                ),
              ),
            ),
            BottomButtonsComponent(
              confirmAction:
                  widget.confirmAction ?? () => Navigator.of(context).pop(_controller.text),
              cancelAction: () => Navigator.of(context).pop(),
              confirmText: widget.confirmText ?? 'Salvar',
            )
          ],
        ),
      ),
    );
  }
}
