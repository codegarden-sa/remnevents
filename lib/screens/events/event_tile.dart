import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../constants/constants.dart';

class EventTile extends StatelessWidget {
  final EventModel event;
  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    // print('::::: ---> {$event.toString()} <----- :::::');
    return Neumorphic(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
          depth: -1,
          lightSource: LightSource.topLeft,
          color: Colors.white),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      color: AppConstants.grey,
                      fontFamily: 'Montserrat',
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Column(
                children: [dayTask(event)],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row dayTask(dynamic event) {
    print(event.startHour);
    // print(event);
    // String startHour = event.startDate.hour.toString();
    // String endHour = event.endDate.hour.toString();
    // print(startHour + " " + endHour);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(4),
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
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.department??'',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      event.startHour + " - " + event.endHour,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    // Icon(Icons.call, color: Colors.purple,),
                    SizedBox(
                      width: 5,
                    ),
                    // Icon(Icons.mail_outline, color: Colors.purple,),
                    Expanded(
                      child: Container(),
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(3),
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(6)),
                          depth: -2,
                          lightSource: LightSource.topLeft,
                          color: Colors.white),
                      // decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Text(
                        event.venue ?? '',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
