import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/components/admin_bar.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/state/app_state.dart';
class EventDetail extends StatefulWidget {
  final EventModel event;
  const EventDetail({Key key, this.event}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  void updateSnackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Status Updated')));
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<AppState>(context, listen: false).isAdmin;
    final isLeader = Provider.of<AppState>(context, listen: false).isLeader;
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
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            bottomContentText,
            isAdmin == true ?
            AdminBar(event: widget.event, updateSnackBar: updateSnackBar) : SizedBox(height: 0.1,)
          ],
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
        SizedBox(height: 30.0),

        isLeader == true || isAdmin == true ?
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.white, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(flex: 1, child: Text(widget.event.status)),
            ))
          ],
        ) : SizedBox(height: 0.1,),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}
