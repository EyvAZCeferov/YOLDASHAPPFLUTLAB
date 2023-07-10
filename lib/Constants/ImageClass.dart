import 'package:flutter/material.dart';

class ImageClass extends StatelessWidget {
  final String url;
  final bool type;
  final BoxFit boxfit;

  const ImageClass(
      {required this.url, required this.type, this.boxfit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return this.type == true
        ? Image.network(
            url,
            fit: boxfit,
          )
        : Image.asset(
            url,
            fit: boxfit,
          );
  }
}
