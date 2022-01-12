import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryModel {
  CategoryModel({
    this.id,
    this.name = '',
    this.color = '',
    required this.icon,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id_categoria'] as int;
    name = json['ds_nome'];
    color = json['nm_cor'];
    icon = getIcon(name);
  }

  IconData getIcon(String value) {
    IconData result = FontAwesomeIcons.frownOpen;

    switch (value) {
      case 'Ansiedade':
        result = FontAwesomeIcons.frownOpen;
        break;
      case 'Raiva':
        result = FontAwesomeIcons.angry;
        break;
      case 'Tristeza':
        result = FontAwesomeIcons.sadTear;
        break;
      case 'Insônia':
        result = FontAwesomeIcons.flushed;
        break;
      case 'Angústia':
        result = FontAwesomeIcons.frown;
        break;
      case 'Fome':
        result = FontAwesomeIcons.grinTongue;
        break;
      case 'TDA':
        result = FontAwesomeIcons.mehBlank;
        break;
    }
    return result;
  }

  int? id;
  late String color;
  late String name;
  late IconData icon;
}
