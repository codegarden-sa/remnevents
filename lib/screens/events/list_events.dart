import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/screens/events/event_list.dart';
import 'package:sandtonchurchapp/screens/events/event_tile.dart';
import 'package:sandtonchurchapp/services/events_firestore_services.dart';
// import '../models/event.dart';÷
import 'package:sandtonchurchapp/models/event.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:provider/provider.dart';

class ListEvents extends StatelessWidget {
  final String eventListType;
  final String uid;
  ListEvents({this.eventListType, this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamProvider<List<EventModel>>.value(
            value: eventListType == AppConstants.APPROVED
                ? DatabaseService().approvedEvents
                : eventListType == AppConstants.LEADER 
                ? DatabaseService(uid: uid).leaderEvents
                : DatabaseService().pendingEvents,
            child: SafeArea(
              child: Scaffold(
                   appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Events', style: TextStyle(color: AppConstants.darkblue, fontSize: 25),),
          ],
        ),
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
