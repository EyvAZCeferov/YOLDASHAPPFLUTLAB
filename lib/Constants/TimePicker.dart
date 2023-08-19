import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimePicker extends StatelessWidget {
  final DateTime initialTime;
  final Function(DateTime) onTimeSelected;

  TimePicker({
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TimePickerSpinner(
          is24HourMode: true,
          normalTextStyle: TextStyle(fontSize: 24),
          highlightedTextStyle:
              TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          spacing: 50,
          itemHeight: 80,
          isForce2Digits: true,
          onTimeChange: (time) {
            final selectedTime = DateTime(
              initialTime.year,
              initialTime.month,
              initialTime.day,
              time.hour,
              time.minute,
            );
            onTimeSelected(selectedTime);
          },
        ),
        );
  }
}
