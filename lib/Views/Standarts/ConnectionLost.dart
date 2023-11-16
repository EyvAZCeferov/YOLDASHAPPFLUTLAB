import 'dart:async';

import 'package:flutter/material.dart';
import '../../Constants/ImageClass.dart';
import '../../Functions/helpers.dart';
import '../../Theme/ThemeService.dart';

class ConnectionLost extends StatefulWidget {
  @override
  _ConnectionLostState createState() => _ConnectionLostState();
}

class _ConnectionLostState extends State<ConnectionLost> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkconnectionandsendresult('connectionlost');
    });
  }

  void _cancelTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whitecolor,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Center(
        child: ImageClass(
          type: false,
          boxfit: BoxFit.contain,
          url: "assets/images/no_internet_connection.jpg",
        ),
      ),
    );
  }
}
