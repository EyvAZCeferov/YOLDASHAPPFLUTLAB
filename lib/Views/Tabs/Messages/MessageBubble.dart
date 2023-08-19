import 'package:flutter/material.dart';

import '../../../Constants/StaticText.dart';
import '../../../Theme/ThemeService.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMine;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isMine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: isMine ? primarycolor : Colors.white,
        borderRadius: get_border_radius(isMine),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Align(
        alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: StaticText(
          text: message,
          color: isMine ? whitecolor : darkcolor,
          size: normaltextSize,
          align: isMine ? TextAlign.right : TextAlign.left,
          weight: FontWeight.w400,
        ),
      ),
    );
  }

  BorderRadius get_border_radius(bool type) {
    if (type == true) {
      return BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(0),
      );
    } else {
      return BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(15),
      );
    }
  }
}
