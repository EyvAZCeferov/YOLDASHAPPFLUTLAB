import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputElement extends StatefulWidget {
  final String placeholder;
  final Color accentColor;
  final Color textColor;
  final EdgeInsets margin;
  final BorderRadius cornerradius;
  final TextInputType inputType;
  final TextEditingController controller;

  const InputElement(
      {required this.placeholder,
      required this.accentColor,
      required this.textColor,
      this.margin = const EdgeInsets.only(bottom: 5),
      this.cornerradius = const BorderRadius.all(Radius.circular(10)),
      this.inputType = TextInputType.text,
      required this.controller});
  @override
  State<InputElement> createState() => _InputElementState();
}

class _InputElementState extends State<InputElement> {
  String validatemessage = '';

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: widget.cornerradius,
      borderSide: BorderSide(
        color: Colors.red, // İstediğiniz renge ayarlayabilirsiniz
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );
    return Container(
      margin: widget.margin,
      color: Colors.transparent,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText:
            widget.inputType == TextInputType.visiblePassword ? true : false,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
          border: outlineInputBorder,
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.cornerradius,
            borderSide: BorderSide(
              color: widget.accentColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.cornerradius,
            borderSide: BorderSide(
              color: widget.accentColor,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: widget.cornerradius,
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
