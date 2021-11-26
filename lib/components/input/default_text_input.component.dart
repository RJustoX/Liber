import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultTextInputComponent extends StatelessWidget {
  const DefaultTextInputComponent({
    required this.title,
    this.hint,
  });

  final String title;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: HexColor('#B0B4C0'),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
            fillColor: HexColor('#CAD4DF'),
            filled: true,
          ),
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return 'Campo não preenchido';
          //   } else
          //     return null;
          // },
          // onSaved: (nickname) {
          //   _newUser.nickname = nickname!;
          // },
        ),
      ],
    );
  }
}
