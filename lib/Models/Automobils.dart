import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Automobils {
  final IconData icon;
  final String name;
  final String statebadge;
  bool value;

  Automobils(
      {required this.icon,
      required this.name,
      required this.statebadge,
      required this.value});
}
