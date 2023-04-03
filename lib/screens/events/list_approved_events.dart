import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remnevents/screens/events/event_list.dart';
import 'package:remnevents/services/events_firestore_services.dart';
// import '../models/event.dart';÷
import 'package:remnevents/models/event.dart';
import 'package:remnevents/services/database.dart';
import 'package:provider/provider.dart';

class ListApprovedEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamProvider<List<EventModel>>.value(
            value: DatabaseService().approvedEvents,
            child: Container(
              // color: Colors.green,
              child: EventList(),
            )));
  }
}
