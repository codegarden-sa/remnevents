//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/login_page.dart';
import 'package:sandtonchurchapp/screens/auth/widgets/sign_in.dart';
import 'package:sandtonchurchapp/sign_in.dart';
//import 'package:sandtonchurchapp/ui/pages/view_event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/src/material/icons.dart';
import 'booking.dart';
import 'events.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import './res/events_firestore_services.dart';
import './ui/pages/add_event.dart';
import './ui/view_event.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/event.dart';
//void main() {
//runApp(MyApp());
//}

class MyAppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0XFF075E54), accentColor: Color(0XFF25D366)),
      debugShowCheckedModeBanner: false,
      home: Calendar(),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
//  final String apiUrl =
  //    "https://script.google.com/macros/s/AKfycbzsVeDqJ7fRzrsixxztlj16mryTo6JYvuyqQxiKU5ogkBtN3Gk/exec";

  //Future<List<dynamic>> fetchUsers() async {
  // var result = await http.get(apiUrl);
  //  return json.decode(result.body)['user'];
  // }

  //String _startDate(dynamic user) {
  //var identity = user['startDate'];
  //return '$identity';
  //}

  //String _endDate(dynamic user) {
  //return user['endDate'];
  //}

  //String _time(dynamic user) {
  //return user['time'];
  //}

  // String _dept(dynamic user) {
  //  return user['dept'];
  // }

  //String _event(dynamic user) {
  //return user['event'];
  //}

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  DateTime get date => null;

  //initPrefs() async {
  // prefs = await SharedPreferences.getInstance();
  // setState(() {
  //   _events = Map<DateTime, List<dynamic>>.from(
  //     decodeMap(json.decode(prefs.getString("bookings") ?? "{}")));
  //});
  // }

//  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  //  Map<String, dynamic> newMap = {};
  //  map.forEach((key, value) {
  //     newMap[key.toString()] = map[key];
  //   });
  //   return newMap;
  // }

//  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  //   Map<DateTime, dynamic> newMap = {};
  //  map.forEach((key, value) {
  //   newMap[DateTime.parse(key)] = map[key];
//    });
  //  return newMap;
//  }

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
    //print(data);
    //  print('here');

    return data;
  }

  @override
  Widget build(BuildContext context) {
    print(_events);
    return SafeArea(
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            title: Text('SDA Calendar',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600)),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(7, 94, 84, 1.0),
            leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Menu Icon',
              onPressed: () {},
            ),
            //  bottom: PreferredSize(
            //    child: Icon(Icons.linear_scale, size: 60.0),
            //  preferredSize: Size.fromHeight(50.0)),
            brightness: Brightness.dark,
            elevation: 50.0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.search),
              ),
              //  Padding(
              //  padding: EdgeInsets.only(right: 16.0),
              //child: Icon(Icons.person),
              //),
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Logout',
                      style: TextStyle(
                          fontFamily: 'montserrati', color: Colors.white)),
                  onPressed: () {
                    googleSignIn.signOut();
                    context.signOut();
                    Navigator.of(context).push(AuthScreen.route);
                  }
                  //IconButton(

                  //icon: Icon(Icons.person),
                  //tooltip: 'Logout',
                  //onPressed: () {},
                  //),
                  )
            ],
          ),
          body: StreamBuilder<List<EventModel>>(
              stream: eventDBS.streamList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<EventModel> allEvents = snapshot.data;
                  if (allEvents.isNotEmpty) {
                    _events = _groupEvents(allEvents);
                    print(_events);
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
                          color: Color.fromRGBO(7, 94, 84, 1.0),
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
                                markersColor: Colors.white,
                                weekdayStyle: TextStyle(color: Colors.white),
                                todayColor: Colors.white54,
                                todayStyle: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                selectedColor: Colors.red[900],
                                outsideWeekendStyle:
                                    TextStyle(color: Colors.white60),
                                outsideStyle: TextStyle(color: Colors.white60),
                                weekendStyle: TextStyle(color: Colors.red),
                                renderDaysOfWeek: false,
                              ),
                              headerStyle: HeaderStyle(
                                leftChevronIcon: Icon(Icons.arrow_back_ios,
                                    size: 15, color: Colors.white),
                                rightChevronIcon: Icon(Icons.arrow_forward_ios,
                                    size: 15, color: Colors.white),
                                titleTextStyle: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 16),
                                formatButtonTextStyle:
                                    TextStyle(color: Colors.white),
                                formatButtonShowsNext: false,
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
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                                todayDayBuilder: (context, date, events) =>
                                    Container(
                                        margin: const EdgeInsets.all(4.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          date.day.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )),
                              ),
                              calendarController: _controller,
                            ),
                            //Text('$_selectedEvents'),
                            /* ..._selectedEvents.map((event) => ListTile(
                                  title: Text(event.title),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => EventDetailsPage(
                                                  event: event,
                                                )));
                                  },
                                )), */
                          ],
                        ),
                      ),
                    ),
                    /* Text('${event.description}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'montseratti',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )), */
                    ..._selectedEvents.map((event) => ListTile(
                          tileColor: Colors.lightGreen,
                          title: Text(event.title,
                              style: TextStyle(
                                  fontFamily: 'montseratti',
                                  fontSize: 20,
                                  color: Colors.blue)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EventDetailsPage(
                                          event: event,
                                        )));
                          },
                        )),
                    /*   Text('Events'),
                    ..._selectedEvents.map((event) => ListTile(
                          title: Text(event.description),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EventDetailsPage(
                                          event: event,
                                        )));
                          },
                        )), */

                    ///      margin: EdgeInsets.only(top: 20),
                    //    ),
                    //    Container(
                    //       margin: EdgeInsets.fromLTRB(4, 20, 4, 0),
                    //      child: RaisedButton(
                    //         child: Text('View detailed Events'),
                    //        color: Colors.blueGrey,
                    //         onPressed: () {
                    //          Navigator.push(
                    //                context,
                    //                 MaterialPageRoute(
                    //                    builder: (context) => Home()));
                    //           },
                    //         ),
                    //      ),
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(4, 20, 4, 0),
                    //   child: RaisedButton(
                    //     child: Text('Add Events to Calendar'),
                    //     color: Colors.blueGrey,
                    //    onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //            MaterialPageRoute(
                    //               builder: (context) => MyHomePage()));
                    //     },
                    //  ),
                    //),
                  ],
                );
              }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddEventPage())),
          ),
          bottomNavigationBar: BottomNavigationBar(
            //  backgroundColor: Color.fromRGBO(7, 94, 84, 1.0),
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(7, 94, 84, 1.0),
                icon: Icon(Icons.add, color: Colors.white),
                title: Text('Add Event',
                    style: TextStyle(
                        fontFamily: 'montseratti', color: Colors.white)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, color: Colors.white),
                title: Text('Events',
                    style: TextStyle(
                        fontFamily: 'montseratti', color: Colors.white)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book, color: Colors.white),
                title: Text('Booking',
                    style: TextStyle(
                        fontFamily: 'montseratti', color: Colors.white)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.white),
                title: Text('Profile',
                    style: TextStyle(
                        fontFamily: 'montseratti', color: Colors.white)),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          // child: Icon(Icons.add),
          // onPressed: _showAddDialog,
          // ),
        ),
      ),
    );
  }
}
