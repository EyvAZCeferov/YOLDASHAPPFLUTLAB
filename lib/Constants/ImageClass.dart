import 'package:flutter/material.dart';

class ImageClass extends StatelessWidget {
  final String url;
  final bool type;

  const ImageClass({required this.url, required this.type});

  @override
  Widget build(BuildContext context) {
    return this.type == true ? Image.network(url) : Image.asset(url);
  }
}
