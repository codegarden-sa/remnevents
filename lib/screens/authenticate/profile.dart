import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:sandtonchurchapp/state/user_state.dart';

class Profile extends StatelessWidget {
  // const Profile({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final setIsLeader =
        Provider.of<UserState>(context, listen: false).setIsLeader;
    // return either the Home or Authenticate widget

    print('in the profile');
    if (user == null) {
      return Authenticate();
      // _userState.setIsLeader("viwer");

    } else {
      return StreamBuilder<UserDetails>(
          stream: DatabaseService(uid: user.uid).userDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserDetails userInfo = snapshot.data;
              print('userinfo name');
              print(userInfo.name);
              // return Consumer<UserState>(builder: (context, userState, child) {
              // userState.setIsLeader(userInfo.status);
              setIsLeader(userInfo.status);
              return SingleChildScrollView(
                  child: Container(
                child: Column(
                  children: [
                    Text('Hi, ' + userInfo.name,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w800)),
                    SizedBox(height: 20.0),
                    InkWell(
                      child: Text('Logout'),
                      onTap: () async {
                        await _auth.signOut();
                        // userState.setIsLeader('viewer');
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
