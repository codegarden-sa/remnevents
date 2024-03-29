import 'package:flutter/material.dart';
import 'package:remnevents/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:remnevents/models/event.dart';
import 'package:remnevents/screens/events/event_tile.dart';

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
              // margin: EdgeInsets.only(bottom: 40),
              padding: EdgeInsets.only(bottom: 15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .84 -
                  kBottomNavigationBarHeight,

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
                    return EventTile(
                      event: events[index],
                      showNotification: false,
                    );

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
