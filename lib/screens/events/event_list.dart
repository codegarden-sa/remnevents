import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/screens/events/event_tile.dart';
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

    return Scaffold(
          appBar: AppBar(title: Text('All Programs', style: TextStyle(color: AppConstants.darkblue,fontSize: 30),), elevation: 0.0, backgroundColor: Colors.transparent,),
          body: SafeArea(
                      child: Column(
        children: [

            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                // margin: Margin,
                          padding: EdgeInsets.only(left: 25, right: 15),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            color: AppConstants.darkblue,
                          ),
                
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EventTile(event: events[index]);
                  },
                ),
              ),
            ),
        ],
      ),
          ),
    );
  }
}
