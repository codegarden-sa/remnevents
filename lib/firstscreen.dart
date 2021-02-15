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
import './color_scheme.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sandtonchurchapp/widgets/bottom_nav_bar.dart';
import 'models/event.dart';
import 'calendar_events.dart';


//void main() {
//runApp(MyApp());
//}

class MyAppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0XFF075E54),
          accentColor: Color(0XFF25D366),
          fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      title: 'Eventist',
      home: Home(),
    );
  }
}


class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Refectoring'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

// class Calendar extends StatefulWidget {
//   @override
//   _CalendarState createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
// //  final String apiUrl =
//   //    "https://script.google.com/macros/s/AKfycbzsVeDqJ7fRzrsixxztlj16mryTo6JYvuyqQxiKU5ogkBtN3Gk/exec";

//   //Future<List<dynamic>> fetchUsers() async {
//   // var result = await http.get(apiUrl);
//   //  return json.decode(result.body)['user'];
//   // }

//   //String _startDate(dynamic user) {
//   //var identity = user['startDate'];
//   //return '$identity';
//   //}

//   //String _endDate(dynamic user) {
//   //return user['endDate'];
//   //}

//   //String _time(dynamic user) {
//   //return user['time'];
//   //}

//   // String _dept(dynamic user) {
//   //  return user['dept'];
//   // }

//   //String _event(dynamic user) {
//   //return user['event'];
//   //}

//   CalendarController _controller;
//   Map<DateTime, List<dynamic>> _events;
//   List<dynamic> _selectedEvents;
//   TextEditingController _eventController;
//   SharedPreferences prefs;

//   DateTime get date => null;

//   //initPrefs() async {
//   // prefs = await SharedPreferences.getInstance();
//   // setState(() {
//   //   _events = Map<DateTime, List<dynamic>>.from(
//   //     decodeMap(json.decode(prefs.getString("bookings") ?? "{}")));
//   //});
//   // }

// //  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
//   //  Map<String, dynamic> newMap = {};
//   //  map.forEach((key, value) {
//   //     newMap[key.toString()] = map[key];
//   //   });
//   //   return newMap;
//   // }

// //  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
//   //   Map<DateTime, dynamic> newMap = {};
//   //  map.forEach((key, value) {
//   //   newMap[DateTime.parse(key)] = map[key];
// //    });
//   //  return newMap;
// //  }

//   @override
//   void initState() {
//     super.initState();
//     _controller = CalendarController();
//     _eventController = TextEditingController();
//     _events = {};
//     _selectedEvents = [];
//     // initPrefs();
//   }

//   Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
//     Map<DateTime, List<dynamic>> data = {};
//     allEvents.forEach((event) {
//       DateTime date = DateTime(
//           event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
//       if (data[date] == null) data[date] = [];
//       data[date].add(event);
//     });
//     //print(data);
//     //  print('here');

//     return data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print(_events);
//     // var size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Center(
//         child: Scaffold(
//           // backgroundColor: AppColors.lightgrey,
//           // appBar: AppBar(elevation: 0,
//           // backgroundColor: Colors.transparent,
//           // title: Text('SDA Calendar')),
//           // appBar: AppBar(
//           //   title: Text('SDA Calendar',
//           //       style: TextStyle(
//           //           color: Colors.white,
//           //           fontSize: 22.0,
//           //           fontWeight: FontWeight.w600)),
//           //   centerTitle: true,
//           //   backgroundColor: Color.fromRGBO(7, 94, 84, 1.0),
//           //   leading: IconButton(
//           //     icon: Icon(Icons.menu),
//           //     tooltip: 'Menu Icon',
//           //     onPressed: () {},
//           //   ),
//           //   //  bottom: PreferredSize(
//           //   //    child: Icon(Icons.linear_scale, size: 60.0),
//           //   //  preferredSize: Size.fromHeight(50.0)),
//           //   brightness: Brightness.dark,
//           //   elevation: 50.0,
//           //   actions: <Widget>[
//           //     Padding(
//           //       padding: const EdgeInsets.only(right: 20.0),
//           //       child: Icon(Icons.search),
//           //     ),
//           //     //  Padding(
//           //     //  padding: EdgeInsets.only(right: 16.0),
//           //     //child: Icon(Icons.person),
//           //     //),
//           //     FlatButton.icon(
//           //         icon: Icon(Icons.person),
//           //         label: Text('Logout',
//           //             style: TextStyle(
//           //                 fontFamily: 'montserrati', color: Colors.white)),
//           //         onPressed: () {
//           //           googleSignIn.signOut();
//           //           context.signOut();
//           //           Navigator.of(context).push(AuthScreen.route);
//           //         }
//           //         //IconButton(

//           //         //icon: Icon(Icons.person),
//           //         //tooltip: 'Logout',
//           //         //onPressed: () {},
//           //         //),
//           //         )
//           //   ],
//           // ),
//           body: StreamBuilder<List<EventModel>>(
//               stream: eventDBS.streamList(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   List<EventModel> allEvents = snapshot.data;
//                   if (allEvents.isNotEmpty) {
//                     _events = _groupEvents(allEvents);
//                     // print(_events);
//                   } else {
//                     _events = {};
//                     _selectedEvents = [];
//                   }
//                 }
//                 return ListView(
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.fromLTRB(4, 20, 4, 0),
//                       decoration: BoxDecoration(
//                           color: Colors.transparent,
//                           borderRadius: BorderRadius.circular(10.0)),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             TableCalendar(
//                               events: _events,
//                               initialCalendarFormat: CalendarFormat.month,
//                               calendarStyle: CalendarStyle(
//                                 canEventMarkersOverflow: true,
//                                 markersColor: AppColors.guava,
//                                 markersMaxAmount: 1,
//                                 weekdayStyle: TextStyle(
//                                     color: AppColors.darkblue, fontSize: 18),
//                                 todayStyle: TextStyle(
//                                     color: Colors.redAccent,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                                 outsideWeekendStyle:
//                                     TextStyle(color: AppColors.darkblue),
//                                 outsideStyle:
//                                     TextStyle(color: AppColors.darkblue),
//                                 weekendStyle: TextStyle(
//                                     color: AppColors.darkblue, fontSize: 18),
//                                 renderDaysOfWeek: true,
//                               ),
//                               daysOfWeekStyle: DaysOfWeekStyle(
//                                   weekdayStyle:
//                                       TextStyle(color: AppColors.darkblue),
//                                   weekendStyle:
//                                       TextStyle(color: AppColors.darkblue)),
//                               headerStyle: HeaderStyle(
//                                 leftChevronIcon: Icon(Icons.arrow_back_ios,
//                                     size: 15, color: AppColors.darkblue),
//                                 rightChevronIcon: Icon(Icons.arrow_forward_ios,
//                                     size: 15, color: AppColors.darkblue),
//                                 leftChevronMargin: EdgeInsets.only(left: 70),
//                                 rightChevronMargin: EdgeInsets.only(right: 70),
//                                 titleTextStyle: GoogleFonts.montserrat(
//                                     color: AppColors.darkblue, fontSize: 16),
//                                 centerHeaderTitle: true,
//                                 formatButtonVisible: false,
//                               ),
//                               startingDayOfWeek: StartingDayOfWeek.monday,
//                               onDaySelected: (date, events, _) {
//                                 //  print('here');
//                                 //  print(events);
//                                 setState(() {
//                                   _selectedEvents = events;
//                                 });
//                               },
//                               builders: CalendarBuilders(
//                                 selectedDayBuilder: (context, date, events) =>
//                                     Container(
//                                         margin: const EdgeInsets.all(4.0),
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             color: AppColors.lightgrey,
//                                             borderRadius:
//                                                 BorderRadius.circular(50.0)),
//                                         child: Text(
//                                           date.day.toString(),
//                                           style: TextStyle(
//                                               color: AppColors.darkblue,
//                                               fontSize: 18),
//                                         )),
//                                 todayDayBuilder: (context, date, events) =>
//                                     Container(
//                                         margin: const EdgeInsets.all(4.0),
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             // color:
//                                             //     AppColors.lightgrey,
//                                             borderRadius:
//                                                 BorderRadius.circular(50.0)),
//                                         child: Text(
//                                           date.day.toString(),
//                                           style: TextStyle(
//                                               color: AppColors.guava,
//                                               fontSize: 19,
//                                               fontWeight: FontWeight.w900),
//                                         )),
//                               ),
//                               calendarController: _controller,
//                             ),
//                             //Text('$_selectedEvents'),
//                             /* ..._selectedEvents.map((event) => ListTile(
//                                       title: Text(event.title),
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (_) => EventDetailsPage(
//                                                       event: event,
//                                                     )));
//                                       },
//                                     )), */
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   height: size.height * .45,
//                     //   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),

//                     // ),
//                     // Expanded(child: _buildEventList()),
//                     // _buildEventList(),
//                     ..._selectedEvents.map((event) => Neumorphic(
//                           margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 8),
//                           style: NeumorphicStyle(
//                               shape: NeumorphicShape.concave,
//                               boxShape: NeumorphicBoxShape.roundRect(
//                                   BorderRadius.circular(6)),
//                               depth: -1,
//                               lightSource: LightSource.topLeft,
//                               color: AppColors.lightgrey),
//                           // decoration: BoxDecoration(
//                           //   color: AppColors.lightgrey,
//                           //   borderRadius: BorderRadius.all(Radius.circular(12)),
//                           //   boxShadow: AppColors.neumorpShadow
//                           // ),
//                           // child: Column(
//                           //   children: <Widget>[
//                           //     Container(
//                           //       child: ListTile(
//                           //         title: Text(event.title, style: TextStyle(color: AppColors.darkblue, fontSize: 22),),
//                           //         onTap: () => print('$event tapped!'),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           child: Container(
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         event.title,
//                                         style: TextStyle(
//                                           color: AppColors.grey,
//                                           fontFamily: 'Montserrat',
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.w800,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 2,
//                                   ),
//                                   Column(
//                                     children: [dayTask(event)],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                     // Expanded(child: _buildEventList()),
//                     /* Text('${event.description}',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontFamily: 'montseratti',
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             )), */
//                     /*   Text('Events'),
//                         ..._selectedEvents.map((event) => ListTile(
//                               title: Text(event.description),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => EventDetailsPage(
//                                               event: event,
//                                             )));
//                               },
//                             )), */

//                     ///      margin: EdgeInsets.only(top: 20),
//                     //    ),
//                     //    Container(
//                     //       margin: EdgeInsets.fromLTRB(4, 20, 4, 0),
//                     //      child: RaisedButton(
//                     //         child: Text('View detailed Events'),
//                     //        color: Colors.blueGrey,
//                     //         onPressed: () {
//                     //          Navigator.push(
//                     //                context,
//                     //                 MaterialPageRoute(
//                     //                    builder: (context) => Home()));
//                     //           },
//                     //         ),
//                     //      ),
//                     // Container(
//                     //   margin: EdgeInsets.fromLTRB(4, 20, 4, 0),
//                     //   child: RaisedButton(
//                     //     child: Text('Add Events to Calendar'),
//                     //     color: Colors.blueGrey,
//                     //    onPressed: () {
//                     //       Navigator.push(
//                     //           context,
//                     //            MaterialPageRoute(
//                     //               builder: (context) => MyHomePage()));
//                     //     },
//                     //  ),
//                     //),
//                   ],
//                 );
//               }),

//           floatingActionButton: NeumorphicButton(
//             // backgroundColor: AppColors.grey,

//             style: NeumorphicStyle(
//                 shape: NeumorphicShape.flat,
//                 boxShape: NeumorphicBoxShape.circle(),
//                 depth: 6,
//                 lightSource: LightSource.topLeft,
//                 color: AppColors.grey),
//             child: NeumorphicIcon(Icons.add, size: 30),
//             onPressed: () => Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => AddEventPage())),
//           ),
//           backgroundColor: Colors.white,

//           bottomNavigationBar: BottomNavBar(),
//           // floatingActionButton: FloatingActionButton(
//           // child: Icon(Icons.add),
//           // onPressed: _showAddDialog,
//           // ),
//         ),
//       ),
//     );
//   }

//   Row dayTask(dynamic event) {
//     print("task --> $event");
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(2),
//               margin: EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                   color: AppColors.guava,
//                   borderRadius: BorderRadius.all(Radius.circular(100))),
//               // width: MediaQuery.of(context).size.width*0.1,
//               child: Text(
//                 "",
//                 style: TextStyle(
//                   color: Colors.pink,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//         Expanded(
//           child: Container(
//             // margin: EdgeInsets.only(bottom: 20),
//             // padding: EdgeInsets.all(20),
//             color: AppColors.lightgrey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Pathfinder',
//                   style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "9am - 5 pm",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 13,
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 2,
//                 ),
//                 Row(
//                   children: [
//                     // Icon(Icons.call, color: Colors.purple,),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     // Icon(Icons.mail_outline, color: Colors.purple,),
//                     Expanded(
//                       child: Container(),
//                     ),
//                     Neumorphic(
//                       padding: EdgeInsets.all(3),
//                       style: NeumorphicStyle(
//                           shape: NeumorphicShape.concave,
//                           boxShape: NeumorphicBoxShape.roundRect(
//                               BorderRadius.circular(6)),
//                           depth: -2,
//                           lightSource: LightSource.topLeft,
//                           color: AppColors.lightgrey),
//                       // decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
//                       child: Text(
//                         "Local church",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 14,
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
