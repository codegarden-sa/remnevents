import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:sandtonchurchapp/constants/constants.dart';

class DateTimeFld extends StatefulWidget {
  // DateTimeFld({Key key}) : super(key: key);/

  final Function setDateTime;
  DateTimeFld({this.setDateTime});

  @override
  _DateTimeFldState createState() => _DateTimeFldState();
}

class _DateTimeFldState extends State<DateTimeFld> {
  DateTime selectedDate;

  DateTime startDate;
  DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
        Form(
          child: Column(
            children: [
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Start DateTime',
                ),
                autovalidateMode: AutovalidateMode.always,
                validator: (val) =>
                    val.toString().isEmpty ? 'DateTime is required' : null,
                onDateSelected: (DateTime date) {
                  setState(() {
                    startDate = date;
                  });
                },
              ),
              const SizedBox(height: 5),
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'End DateTime',
                ),
                autovalidateMode: AutovalidateMode.always,
                validator: (val) =>
                    val.toString().isEmpty ? 'DateTime is required' : null,
                onDateSelected: (DateTime date) {
                  setState(() {
                    endDate = date;
                  });
                  if (startDate != null && endDate != null)
                    widget.setDateTime(startDate, endDate);
                  else
                    print('date fields are required');
                },
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
    // ));
  }
}
