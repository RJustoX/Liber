import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultTextInputComponent extends StatefulWidget {
  const DefaultTextInputComponent({
    required this.title,
    this.hint,
    this.onSaved,
    this.validate = false,
    this.initialValue,
    this.maxLines = 1,
    this.minLines = 1,
  });

  final String title;
  final String? hint, initialValue;
  final Function(String?)? onSaved;
  final bool validate;
  final int minLines;
  final int maxLines;

  @override
  State<DefaultTextInputComponent> createState() => _DefaultTextInputComponentState();
}

class _DefaultTextInputComponentState extends State<DefaultTextInputComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(
            color: HexColor('#B0B4C0'),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          initialValue: widget.initialValue,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          decoration: InputDecoration(
            hintText: widget.hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
            fillColor: HexColor('#CAD4DF'),
            filled: true,
          ),
          validator: widget.validate
              ? (value) {
                  if (value!.isEmpty) {
                    return 'Campo não preenchido';
                  } else
                    return null;
                }
              : (value) {
                  return null;
                },
          onSaved: widget.onSaved,
        ),
      ],
    );
  }
}
