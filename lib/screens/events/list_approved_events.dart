import 'package:flutter/material.dart';
import 'package:remnevents/screens/events/event_list.dart';
import 'package:remnevents/models/event.dart';
import 'package:remnevents/services/database.dart';
import 'package:provider/provider.dart';

class ListApprovedEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<EventModel>>.value(
      value: DatabaseService(uid: '').approvedEvents,
      initialData: const [],
      child: Container(
        child: EventList(),
      ),
    );
  }
}
