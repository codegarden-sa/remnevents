import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:sandtonchurchapp/screens/home.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/constants/loading.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:sandtonchurchapp/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final setIsLeader =
        Provider.of<AppState>(context, listen: false).setIsLeader;
    final setIsAdmin = Provider.of<AppState>(context, listen: false).setIsAdmin;
    final setIsViewer =
        Provider.of<AppState>(context, listen: false).setIsViewer;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstants.darkblue, //change your color here
        ),
        title: Text(
          "Sign In",
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
      body: loading
          ? Loading()
          : Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                padding: EdgeInsets.only(left: 25, right: 15),
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: AppConstants.darkblue,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: AppConstants.textInputDecoration
                            .copyWith(hintText: 'email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: AppConstants.textInputDecoration
                            .copyWith(hintText: 'password'),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: AppConstants.grey,
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic uid = await _auth
                                  .signInWithEmailAndPassword(email, password);

                              if (uid != null) {
                                // setState(() => loading = false);
                                print(':: signin :: results' + uid);

                                DatabaseService(uid: uid).refreshUserStatus().then(
                                    (subscription) async {
                                  final SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  StreamSubscription<UserDetails> sub =
                                      subscription;
                                  sub.onData((userInfo) {
                                    sharedPreferences.setString('uid', uid);
                                    print(':: sing in :: inserting name ' +
                                        userInfo.name);
                                    sharedPreferences.setString(
                                        'name', userInfo.name);

                                    sharedPreferences.setString(
                                        'status', userInfo.status);
                                    print(
                                        'Inserting/Refreshing user status [status]:: ' +
                                            userInfo.status);
                                    loading = false;

                                    if (userInfo.status != null) if (userInfo
                                                .status ==
                                            AppConstants.LEADER ||
                                        userInfo.status ==
                                            AppConstants.ADMINISTRATOR) {
                                      setIsAdmin(userInfo.status);
                                      setIsLeader(userInfo.status);
                                      // setIsViewer(userInfo.status);
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    }
                                  });
                                }).catchError((error) => print(
                                    ':: sign in :: error refreshing status from sign in ' +
                                        error.toString()));
                              }
                            } else {
                              setState(() => loading = false);
                              //TODO: include a snackbar to inform the user
                              print(
                                  ':: sign in :: error signing in this user, check logs for details ');
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: AppConstants.lightgrey, fontSize: 18),
                          ),
                          onTap: () => widget.toggleView(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
