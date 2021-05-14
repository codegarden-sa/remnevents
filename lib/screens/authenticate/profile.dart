import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:sandtonchurchapp/screens/events/list_events.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:sandtonchurchapp/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  // const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  Future<Map> _retrieveDetails() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String name = sharedPreferences.getString('name');
    String status = sharedPreferences.getString('status');
    String uid = sharedPreferences.getString('uid');
    return {'userName': name, 'status': status, 'uid': uid};
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final isLeader = Provider.of<AppState>(context).isLeader;
    final isAdmin = Provider.of<AppState>(context).isAdmin;
    final setIsLeader =
        Provider.of<AppState>(context, listen: false).setIsLeader;

    if (user == null || !isLeader) {
      return Authenticate();
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppConstants.darkblue, //change your color here
            ),
            title: Text(
              "Profile",
              style: TextStyle(color: AppConstants.darkblue, fontSize: 25),
            ),
            backgroundColor: AppConstants.lightgrey,
            elevation: 0,
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25.0),
              ),
            ),
          ),
          body: Center(
            child: FutureBuilder<Map>(
              future: _retrieveDetails(),
              builder: (context, snapshot) {
                final userDetails = snapshot.data;
                if (snapshot.connectionState == ConnectionState.done &&
                    userDetails['userName'] != null) {
                  print(userDetails);

                  return SingleChildScrollView(
                      child: Container(
                    child: Column(
                      children: [
                        Text('Hi, ' + userDetails['userName'],
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w800)),
                        SizedBox(height: 20.0),
                        isAdmin || isLeader
                            ? RaisedButton(
                                color: AppConstants.darkblue,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child:

                                    // Text('place holder'),

                                    Text(userDetails['status']
                                            .substring(0, 1)
                                            .toUpperCase() +
                                        userDetails['status'].substring(1) +
                                        ' Events Panel'),
                                textColor: Colors.white,
                                onPressed: () {
                                  if (isAdmin)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListEvents(
                                                  eventListType:
                                                      AppConstants.PENDING,
                                                  listTitle: 'Pending Events',
                                                )));

                                  if (isLeader)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListEvents(
                                                eventListType:
                                                    AppConstants.LEADER,
                                                uid: userDetails['uid'],
                                                listTitle: 'My Events')));
                                },
                              )
                            : Text(''),
                        SizedBox(height: 20.0),
                        InkWell(
                          child: Text('Logout'),
                          onTap: () async {
                            await _auth.signOut();
                            // AppState.setIsLeader('viewer');
                            setIsLeader('viewer');
                          },
                        )
                      ],
                    ),
                  ));
                } else
                  return CircularProgressIndicator();
              },
            ),
          ),
        ),
      );

      // });
    }

    // else
    //   return Container(
    //     child: InkWell(
    //       child: Text('No User Data, Tap to logout'),
    //       onTap: () async => await _auth.signOut(),
    //     ),
    //   );
  }
}
