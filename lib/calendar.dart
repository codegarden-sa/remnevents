import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatelessWidget {
  final String apiUrl =
      "https://script.googleusercontent.com/macros/echo?user_content_key=9AeZFAQviACZE2v8__4UGhVJZ4B7fECt55XIfbSIBMGXhrxDrWyeZUduuSw7P3zAeqotKc6J2UR6UZv09fjyNl0n3_qSJ3xnm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnKgLsXHV4aMX-Mqphori-DXv1yMt6i4Bysb6_ENPXi9DOZcO5rRDGB0x1ZqBionbsRdIug5zkO6q&lib=MFre-OyY9LwbvG3dFgU4FVEX2Nb-b482m";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['user'];
  }

  String _id(dynamic user) {
    var identity = user['id'];
    return '$identity';
  }

  String _name(dynamic user) {
    return user['name'];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('User List'),
          backgroundColor: Colors.green,
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

                              title: Text(_id(snapshot.data[index])),
                              trailing: Text(_name(snapshot.data[index])),
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
