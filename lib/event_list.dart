import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/event_tile.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/event.dart';

class EventList extends StatefulWidget {
  // EventList({Key key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<EventModel>>(context) ?? [];

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventTile(event: events[index]);
      },
    );
  }
}
