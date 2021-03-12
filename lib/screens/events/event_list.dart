import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/screens/events/event_tile_.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:sandtonchurchapp/screens/events/event_tile.dart';

class EventList extends StatefulWidget {
  // EventList({Key key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<EventModel>>(context) ?? [];
    return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  // margin: EdgeInsets.only(bottom: 20),
                  // padding: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: AppConstants.darkblue,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return EventTile(event: events[index]);

                        // );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
