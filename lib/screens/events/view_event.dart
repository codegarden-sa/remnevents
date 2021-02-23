import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/screens/events/event_list.dart';
import 'package:sandtonchurchapp/screens/events/event_tile.dart';
import 'package:sandtonchurchapp/services/events_firestore_services.dart';
// import '../models/event.dart';÷
import 'package:sandtonchurchapp/models/event.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:provider/provider.dart';


class ListEvents extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('hello');
    return Container(

  child: StreamProvider<List<EventModel>>.value(
    value: DatabaseService().events,
    child: Container(
      // color: Colors.green,
      child: EventList(),

    )

  
  )

    );
  }
}
