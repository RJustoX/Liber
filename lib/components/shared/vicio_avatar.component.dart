import 'package:flutter/material.dart';
import 'package:nicotine/models/vicio.model.dart';
import 'package:nicotine/views/home/vicio.view.dart';

class VicioAvatarComponent extends StatelessWidget {
  const VicioAvatarComponent(
    this.vicio,
  );
  final VicioModel vicio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) {
            return VicioView();
          },
        ),
      ),
      child: CircleAvatar(
        child: Image.asset(vicio.icon!),
        radius: 16,
      ),
    );
  }
}
