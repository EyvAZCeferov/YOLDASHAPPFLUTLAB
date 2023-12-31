import 'package:flutter/material.dart';

class Devider extends StatelessWidget {
  final double size;
  final bool type;

  const Devider({this.size = 10, this.type = true});

  @override
  Widget build(BuildContext context) {
    return this.type == true
        ? SizedBox(width: double.infinity, height: this.size)
        : SizedBox(
            width: this.size,
            height: 10,
          );
  }
}
