//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/screens/events/event_tile.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:sandtonchurchapp/utils/group_events.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';
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
  bool _isDayEventsEmpty;
  int _tableCalHeight;

  DateTime get date => null;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    _isDayEventsEmpty = true;
    // initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: Center(
      child: Scaffold(
        body: StreamBuilder<List<EventModel>>(
            stream: DatabaseService().approvedEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<EventModel> allEvents = snapshot.data;
                print('allEvents');
                if (allEvents.isNotEmpty) {
                  _events = groupEvents(allEvents);
                } else {
                  _events = {};
                  _selectedEvents = [];
                }
              } else {
                print('no data in snapshot');
              }
              return ListView(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .69 - kBottomNavigationBarHeight - kToolbarHeight,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0)),
                    // child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TableCalendar(
                          events: _events,
                          initialCalendarFormat: CalendarFormat.month,
                          calendarStyle: CalendarStyle(
                            canEventMarkersOverflow: true,
                            markersColor: AppConstants.guava,
                            markersMaxAmount: 1,
                            weekdayStyle: TextStyle(
                                color: AppConstants.darkblue, fontSize: 18),
                            todayStyle: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            outsideWeekendStyle:
                                TextStyle(color: AppConstants.darkblue),
                            outsideStyle:
                                TextStyle(color: AppConstants.darkblue),
                            weekendStyle: TextStyle(
                                color: AppConstants.darkblue, fontSize: 18),
                            renderDaysOfWeek: true,
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle:
                                  TextStyle(color: AppConstants.darkblue),
                              weekendStyle:
                                  TextStyle(color: AppConstants.darkblue)),
                          headerStyle: HeaderStyle(
                            leftChevronIcon: Icon(Icons.arrow_back_ios,
                                size: 15, color: AppConstants.darkblue),
                            rightChevronIcon: Icon(Icons.arrow_forward_ios,
                                size: 15, color: AppConstants.darkblue),
                            leftChevronMargin: EdgeInsets.only(left: 70),
                            rightChevronMargin: EdgeInsets.only(right: 70),
                            titleTextStyle: GoogleFonts.montserrat(
                                color: AppConstants.darkblue, fontSize: 16),
                            centerHeaderTitle: true,
                            formatButtonVisible: false,
                          ),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onDaySelected: (date, events, _) {
                            setState(() {
                              _selectedEvents = events;
                              if (_selectedEvents.length > 0)
                                _isDayEventsEmpty = false;
                              else
                                _isDayEventsEmpty = true;
                            });
                          },
                          builders: CalendarBuilders(
                            selectedDayBuilder: (context, date, events) =>
                                Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppConstants.lightgrey,
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                          color: AppConstants.darkblue,
                                          fontSize: 18),
                                    )),
                            todayDayBuilder: (context, date, events) =>
                                Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        // color:
                                        //     AppConstants.lightgrey,
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                          color: AppConstants.guava,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w900),
                                    )),
                          ),
                          calendarController: _controller,
                        ),
                      ],
                    ),
                    // ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .52 - kBottomNavigationBarHeight - kToolbarHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: AppConstants.darkblue,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          // ),
                          ..._selectedEvents
                              .map((event) => EventTile(event: event)),
                          _isDayEventsEmpty == false
                              ? SizedBox(width: 0, height: 0)
                              :
                              Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, //Center Row contents horizontally,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No Programs',
                                      style: TextStyle(
                                          color: Colors.white60, fontSize: 15),
                                      // )
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
        backgroundColor: Colors.white,
      ),
      // ),
    );
  }
}
