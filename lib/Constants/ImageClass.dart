import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class ImageClass extends StatelessWidget {
  final String url;
  final bool type;
  final BoxFit boxfit;

  const ImageClass(
      {required this.url, required this.type, this.boxfit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return this.type == true
        ? CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundColor: primarycolor,
              foregroundColor: whitecolor,
              radius: 45,
              backgroundImage: imageProvider,
            ),
          )
        : Image.asset(
            url,
            fit: boxfit,
          );
  }
}
