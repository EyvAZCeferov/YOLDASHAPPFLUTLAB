import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bodycolor,
    );
  }
}
