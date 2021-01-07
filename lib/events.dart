import 'dart:developer';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatelessWidget {
  final String apiUrl =
      "https://script.google.com/macros/s/AKfycbzsVeDqJ7fRzrsixxztlj16mryTo6JYvuyqQxiKU5ogkBtN3Gk/exec";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['user'];
  }

  String _startDate(dynamic user) {
    var identity = user['startDate'];
    return '$identity';
  }

  String _endDate(dynamic user) {
    return user['endDate'];
  }

  String _time(dynamic user) {
    return user['time'];
  }

  // String _dept(dynamic user) {
  //  return user['dept'];
  // }

  String _event(dynamic user) {
    return user['event'];
  }

  String _venue(dynamic user) {
    return user['venue'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sandton Year Events'),
          backgroundColor: Color.fromRGBO(7, 94, 84, 1.0),
        ),
        body: Container(
          child: FutureBuilder<List<dynamic>>(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              //leading: CircleAvatar(
                              //  radius: 30,
                              //  backgroundImage: NetworkImage(snapshot
                              //      .data[index]['picture']['large'])),

                              subtitle: Text(
                                _startDate(snapshot.data[index]),
                                style: TextStyle(
                                  fontFamily: 'monseratti',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              // title: Text(_endDate(snapshot.data[index])),
                              title: Text(
                                _event(snapshot.data[index]),
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                _venue(snapshot.data[index]),
                                style: TextStyle(
                                    fontFamily: 'monseratti',
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              //leading: Text(_event(snapshot.data[index])),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
