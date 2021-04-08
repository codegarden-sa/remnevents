import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sandtonchurchapp/components/notification_bar.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _decoratedStatus;

  void updateSnackBar(String txt) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(txt)));
  }

  void decorateStatus(String st) {
    _decoratedStatus = st;
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<AppState>(context, listen: false).isAdmin;
    final isLeader = Provider.of<AppState>(context, listen: false).isLeader;
    _decoratedStatus = widget.event.status;
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
            SizedBox(
              height: 15,
            ),
            NotificationBar(
                event: widget.event, updateSnackBar: updateSnackBar),
            isAdmin == true
                ? AdminBar(
                    event: widget.event,
                    updateSnackBar: updateSnackBar,
                    decorateStatus: decorateStatus)
                : SizedBox(
                    height: 0.1,
                  ),
          ],
        ),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.event.title,
          style: TextStyle(color: AppConstants.guava, fontSize: 25.0, fontWeight: FontWeight.w900,),
        ),
        // SizedBox(height: 30.0),

        isLeader == true || isAdmin == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: AppConstants.skyblue,
                          borderRadius: BorderRadius.all(Radius.circular(2.9))),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(_decoratedStatus),
                      ))
                ],
              )
            : SizedBox(
                height: 0.1,
              ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            margin: EdgeInsets.only(top: 5),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              image: new DecorationImage(
                image: AssetImage('assets/images/sda-sandton.png'),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.fromLTRB(20, 120, 20, 20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(58, 66, 86, .97),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 40.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    return 
    SafeArea(
      child: 
      Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[topContent, bottomContent],
          ),
        ),
      ),
    );
  }
}
