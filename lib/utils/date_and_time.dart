import 'package:flutter/material.dart';

class PickdateAndTime {
  DateTime initialDate = DateTime(2023,03,24,5,30);
  DateTime initialTime = DateTime(2023,03,24,5,30);

  Future<DateTime?> pickDate(BuildContext context) async {

    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2090),
    );

  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    return showTimePicker(
        context: context,
        initialTime:TimeOfDay(hour: initialTime.hour, minute: initialTime.minute),);
  }


 /* Future PicKDateTime(BuildContext context) async {
    DateTime? date = await pickDate(context);
    if (date == null) return;

    TimeOfDay? time = await pickTime(context);
    if (time == null) return;

    final newDateTime =DateTime(
      date.year,
      date.month,
      date.year,
      time.hour,
      time.minute,
    );
    initialDate=newDateTime;
    print('Selected date: $initialDate');

  }*/


}
