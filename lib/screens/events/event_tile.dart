import 'package:flutter/material.dart';
import 'package:remnevents/models/event.dart';
import 'package:remnevents/models/event.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../constants/constants.dart';
import 'event_detail.dart';

class EventTile extends StatelessWidget {
  final EventModel event;
  final showNotification;
  EventTile({this.event, this.showNotification});

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        leading: Container(
          padding: EdgeInsets.fromLTRB(0, 2, 3, 0),
          // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
              color: AppConstants.guava,
              borderRadius: BorderRadius.all(Radius.circular(100))),
          // width: MediaQuery.of(context).size.width*0.1,
          child: Text(
            "",
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(
          event.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text("by " + event.department,
                style: TextStyle(color: Colors.white)),
            Text(
              event.startHour + " - " + event.endHour,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));

    final makeCard = Card(
      elevation: 2.0,
      margin: new EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(44, 75, 96, .9)),
        child: makeListTile,
      ),
    );

    return InkWell(
      child: Container(
        child: makeCard,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetail(
                      event: event,
                      showNotification: showNotification,
                    )));
      },
    );
  }
}
