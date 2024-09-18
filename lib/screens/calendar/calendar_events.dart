import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:remnevents/models/event.dart';
import 'package:remnevents/services/database.dart';

class CalendarEvents extends StatefulWidget {
  @override
  _CalendarEventsState createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<EventModel>> _events = {};
  List<EventModel> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
  }

  void _loadEvents() async {
    final events = await DatabaseService(uid: '').getEvents();
    setState(() {
      _events = events;
    });
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Events'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_selectedEvents[index].title),
                  subtitle: Text(_selectedEvents[index].description),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
