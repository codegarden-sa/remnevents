import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:sandtonchurchapp/screens/events/list_events.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:sandtonchurchapp/state/app_state.dart';

class Profile extends StatelessWidget {
  // const Profile({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final setIsLeader = Provider.of<AppState>(context, listen: false).setIsLeader;
    final setIsAdmin = Provider.of<AppState>(context, listen: false).setIsAdmin;
    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
      // _userState.setIsLeader("viwer");

    } else {
      return StreamBuilder<UserDetails>(
          stream: DatabaseService(uid: user.uid).userDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserDetails userInfo = snapshot.data;
              setIsLeader(userInfo.status);
              setIsAdmin(userInfo.status);
              return SingleChildScrollView(
                  child: Container(
                child: Column(
                  children: [
                    Text('Hi, ' + userInfo.name,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w800)),
                    SizedBox(height: 20.0),
                    userInfo.status == AppConstants.ADMINISTRATOR || userInfo.status == AppConstants.LEADER ? RaisedButton(child: Text('Events Panel'),
                textColor: Colors.grey,
                onPressed: () {
                
                if(userInfo.status == AppConstants.ADMINISTRATOR)
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => ListEvents(eventListType: AppConstants.PENDING,)));

                if(userInfo.status == AppConstants.LEADER)
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => ListEvents(eventListType: AppConstants.LEADER, uid: userInfo.uid)));

                },): Text(''),
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
              // });
            } else
              return Container(
                child: InkWell(
                  child: Text('No User Data, Tap to logout'),
                  onTap: () async => await _auth.signOut(),
                ),
              );
          });
    }
  }
}
