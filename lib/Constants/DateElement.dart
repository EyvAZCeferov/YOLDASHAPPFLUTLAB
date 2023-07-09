import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:yoldash/Constants/StaticText.dart';
import 'package:yoldash/Theme/ThemeService.dart';

class DateElement extends StatefulWidget {
  final String placeholder;
  final Function(DateTime) onDateSelected;
  final Color accentColor;
  final Color textColor;
  final EdgeInsets margin;
  final double fontSize;
  final BorderRadius cornerradius;

  const DateElement({
    required this.placeholder,
    required this.onDateSelected,
    this.accentColor = primarycolor,
    this.textColor = bodycolor,
    this.fontSize = smalltextSize,
    this.margin = const EdgeInsets.only(bottom: 5),
    this.cornerradius = const BorderRadius.all(Radius.circular(10)),
  });

  @override
  _DateElementState createState() => _DateElementState();
}

class _DateElementState extends State<DateElement> {
  DateTime? selectedDate;
  late String displayedText;
  @override
  void initState() {
    super.initState();
    displayedText = selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
        : widget.placeholder;
  }

  @override
  Widget build(BuildContext context) {
    Border outlineborder = Border.all(
      color: primarycolor,
      width: 1,
      style: BorderStyle.solid,
    );

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
          margin: widget.margin,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: widget.cornerradius,
            border: outlineborder,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StaticText(
                color: widget.textColor,
                size: widget.fontSize,
                text: displayedText,
                weight: FontWeight.w200,
                align: TextAlign.left,
              ),
              Icon(
                FeatherIcons.calendar,
                color: darkcolor,
                size: normaltextSize,
              )
            ],
          )),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2090),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        displayedText = DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
      widget.onDateSelected(pickedDate);
    }
  }
}
