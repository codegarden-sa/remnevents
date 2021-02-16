//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/screens/list/event_tile.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../booking/book_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/events_firestore_services.dart';
import '../../constants/color_scheme.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sandtonchurchapp/models/event.dart';

class CalendarEvents extends StatefulWidget {
  @override
  _CalendarEventsState createState() => _CalendarEventsState();
}

class _CalendarEventsState extends State<CalendarEvents> {

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  DateTime get date => null;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    // initPrefs();
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: StreamBuilder<List<EventModel>>(
              stream: eventDBS.streamList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<EventModel> allEvents = snapshot.data;
                  if (allEvents.isNotEmpty) {
                    _events = _groupEvents(allEvents);
                    // print(_events);
                  } else {
                    _events = {};
                    _selectedEvents = [];
                  }
                }
                return ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(4, 20, 4, 0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TableCalendar(
                              events: _events,
                              initialCalendarFormat: CalendarFormat.month,
                              calendarStyle: CalendarStyle(
                                canEventMarkersOverflow: true,
                                markersColor: AppColors.guava,
                                markersMaxAmount: 1,
                                weekdayStyle: TextStyle(
                                    color: AppColors.darkblue, fontSize: 18),
                                todayStyle: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                outsideWeekendStyle:
                                    TextStyle(color: AppColors.darkblue),
                                outsideStyle:
                                    TextStyle(color: AppColors.darkblue),
                                weekendStyle: TextStyle(
                                    color: AppColors.darkblue, fontSize: 18),
                                renderDaysOfWeek: true,
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle:
                                      TextStyle(color: AppColors.darkblue),
                                  weekendStyle:
                                      TextStyle(color: AppColors.darkblue)),
                              headerStyle: HeaderStyle(
                                leftChevronIcon: Icon(Icons.arrow_back_ios,
                                    size: 15, color: AppColors.darkblue),
                                rightChevronIcon: Icon(Icons.arrow_forward_ios,
                                    size: 15, color: AppColors.darkblue),
                                leftChevronMargin: EdgeInsets.only(left: 70),
                                rightChevronMargin: EdgeInsets.only(right: 70),
                                titleTextStyle: GoogleFonts.montserrat(
                                    color: AppColors.darkblue, fontSize: 16),
                                centerHeaderTitle: true,
                                formatButtonVisible: false,
                              ),
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onDaySelected: (date, events, _) {
                                //  print('here');
                                //  print(events);
                                setState(() {
                                  _selectedEvents = events;
                                });
                              },
                              builders: CalendarBuilders(
                                selectedDayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: AppColors.lightgrey,
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(
                                              color: AppColors.darkblue,
                                              fontSize: 18),
                                        )),
                                todayDayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            // color:
                                            //     AppColors.lightgrey,
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(
                                              color: AppColors.guava,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w900),
                                        )),
                              ),
                              calendarController: _controller,
                            ),
                          ],
                        ),
                      ),
                    ),
   
                    ..._selectedEvents.map((event) => EventTile(event: event)),

                  ],
                );
              }),
          floatingActionButton: NeumorphicButton(
            style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 6,
                lightSource: LightSource.topLeft,
                color: AppColors.grey),
            child: NeumorphicIcon(Icons.add, size: 30),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookEvent())),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
