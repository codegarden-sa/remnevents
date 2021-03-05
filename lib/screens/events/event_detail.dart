import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EventDetail extends StatefulWidget {
  final EventModel event;
  const EventDetail({Key key, this.event}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = -1;

    void checkClick(int i) {
      setState(() {
        _currentIndex = i;
      });
    }

    final toggleSwitch = Padding(
        padding: EdgeInsets.only(top: 40),
        child: ToggleSwitch(
          minWidth: 60.0,
          minHeight: 40.0,
          initialLabelIndex: -1,
          cornerRadius: 9.0,
          // activeFgColor: Colors.white,
          activeBgColor: Colors.blue,
          inactiveBgColor: AppConstants.lightgrey,
          inactiveFgColor: Colors.white70,
          labels: ['', '', '', ''],
          icons: [
            FontAwesomeIcons.thumbsUp,
            FontAwesomeIcons.clock,
            FontAwesomeIcons.thumbsDown,
            FontAwesomeIcons.trash,
          ],
          iconSize: 30.0,
          activeBgColors: [Colors.blue, Colors.blue, Colors.blue, Colors.blue],
          onToggle: (index) {
            checkClick(index);
            switch (index) {
              case 0:
                print('approved');
                break;
              case 1:
                print('pending');
                break;
              case 2:
                print('declined');
                break;
              case 3:
                print('deleted');
                break;
              default:
            }
          },
        ));

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        "\$" + '22',
        style: TextStyle(color: Colors.white),
      ),
    );

    final bottomContentText = Text(
      widget.event.description,
      style: TextStyle(fontSize: 18.0),
    );
    final adminButtons = Padding(
        padding: EdgeInsets.fromLTRB(70.0, 90.0, 70.0, 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
            child: FaIcon(
              FontAwesomeIcons.solidThumbsUp,
              size: 30,
              color: Colors.blue,
            ),
            onTap: () {
              print('approved');
            },
          ),
          GestureDetector(
              child: FaIcon(
                FontAwesomeIcons.solidHourglass,
                size: 30,
                color: AppConstants.lightgrey,
              ),
              onTap: () {
                print('pending');
              }),
          GestureDetector(
              child: FaIcon(
                FontAwesomeIcons.solidThumbsDown,
                size: 30,
                color: AppConstants.lightgrey,
              ),
              onTap: () {
                print('declined');
              }),
        ]));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[bottomContentText, toggleSwitch],
        ),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        // Icon(
        //   Icons.directions_car,
        //   color: Colors.white,
        //   size: 40.0,
        // ),
        // Container(
        //   width: 90.0,
        //   child: new Divider(color: Colors.green),
        // ),
        SizedBox(height: 10.0),
        Text(
          widget.event.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        // SizedBox(height: 30.0),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //     Expanded(flex: 1, child: Text('blablab')),
        //     Expanded(
        //         flex: 6,
        //         child: Padding(
        //             padding: EdgeInsets.only(left: 10.0),
        //             child: Text(
        //               'lesson.level',
        //               style: TextStyle(color: Colors.white),
        //             ))),
        //     Expanded(flex: 1, child: coursePrice)
        //   ],
        // ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage('assets/images/sda-sandton.png'),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .97)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}
