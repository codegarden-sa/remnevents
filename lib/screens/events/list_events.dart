import 'package:flutter/material.dart';
import 'package:remnevents/constants/constants.dart';
import 'package:remnevents/screens/events/event_list.dart';
import 'package:remnevents/models/event.dart';
import 'package:remnevents/services/database.dart';
import 'package:provider/provider.dart';

class ListEvents extends StatelessWidget {
  final String? eventListType;
  final String? uid;
  final String listTitle;
  ListEvents({this.eventListType, this.uid, required this.listTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamProvider<List<EventModel>>.value(
            initialData: [], // Add this line
            value: eventListType == AppConstants.APPROVED
                ? DatabaseService(uid: uid).approvedEvents
                : eventListType == AppConstants.LEADER && uid != null
                    ? DatabaseService(uid: uid).leaderEvents
                    : DatabaseService(uid: uid).pendingEvents,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: AppConstants.darkblue, //change your color here
                  ),
                  title: Text(
                    listTitle,
                    style:
                        TextStyle(color: AppConstants.darkblue, fontSize: 25),
                  ),
                  centerTitle: true,
                  //   ],
                  // ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25.0),
                    ),
                  ),
                  backgroundColor: AppConstants.lightgrey,
                  elevation: 0.0,
                ),
                body: Container(
                  // color: Colors.green,
                  child: EventList(),
                ),
              ),
            )));
  }
}
