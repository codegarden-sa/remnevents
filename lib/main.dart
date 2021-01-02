import 'package:flutter/material.dart';
import './calendar.dart';
import './booking.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Nkosi(),
    );
  }
}

class Nkosi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sandton Church Event Calendar'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome to sandton church calnder',
                    style: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  RaisedButton(
                    child: Text('View Calendar'),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text('Book your Event'),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
