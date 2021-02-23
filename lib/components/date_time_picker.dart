import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class DateTimeFld extends StatefulWidget {
  // DateTimeFld({Key key}) : super(key: key);/

  final Function setDateTime;
  DateTimeFld({this.setDateTime});

  @override
  _DateTimeFldState createState() => _DateTimeFldState();
}

class _DateTimeFldState extends State<DateTimeFld> {
  DateTime selectedDate;

  String startDate = '';
  String endDate = '';
  String startTime = '';
  String endTime = '';

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
                  print(date);
                  setState(() {
                    startDate = date.year.toString() +
                        '-' +
                        date.month.toString() +
                        '-' +
                        date.day.toString();
                    startTime =
                        date.hour.toString() + ':' + date.minute.toString();
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
                    endDate = date.year.toString() +
                        '-' +
                        date.month.toString() +
                        '-' +
                        date.day.toString();
                    endTime =
                        date.hour.toString() + ':' + date.minute.toString();
                  });
                  if (startDate != null &&
                      startTime != null &&
                      endTime != null &&
                      endDate != null)
                    widget.setDateTime(startDate, startTime, endDate, endTime);
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
