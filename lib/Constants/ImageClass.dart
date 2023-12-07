import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Theme/ThemeService.dart';

class ImageClass extends StatelessWidget {
  final String url;
  final bool type;
  final BoxFit boxfit;
  final double? radius;

  const ImageClass(
      {required this.url,
      required this.type,
      this.boxfit = BoxFit.contain,
      this.radius = 45});

  @override
  Widget build(BuildContext context) {
    return this.type == true
        ? CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              if (radius != null && radius != 0) {
                return Container(); // Return an empty container
              } else {
                return CircleAvatar(
                  backgroundColor: primarycolor,
                  foregroundColor: whitecolor,
                  radius: radius ?? 0,
                  backgroundImage: imageProvider,
                );
              }
            },
          )
        : Image.asset(
            url,
            fit: boxfit,
          );
  }
}
