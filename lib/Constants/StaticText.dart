import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class StaticText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final double size;
  final Color color;
  final TextAlign align;
  final int? maxline;
  final TextOverflow? textOverflow;

  const StaticText(
      {required this.text,
      required this.weight,
      required this.size,
      required this.color,
      this.align = TextAlign.left,
      this.maxline = 1,
      this.textOverflow = TextOverflow.clip});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxline,
      overflow: textOverflow,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: weight,
        fontSize: size,
      ),
      textAlign: align,
    );
  }
}
