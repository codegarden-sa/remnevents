import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/constants/loading.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/state/user_state.dart';

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
    return loading
        ? Loading()
        : SingleChildScrollView(
            // backgroundColor: Colors.brown[100],
            // appBar: AppBar(
            //   backgroundColor: Colors.brown[400],
            //   elevation: 0.0,
            //   title: Text('Sign in to Brew Crew'),
            //   actions: <Widget>[
            //     FlatButton.icon(
            //       icon: Icon(Icons.person),
            //       label: Text('Register'),
            //       onPressed: () => widget.toggleView(),
            //     ),
            //   ],
            // ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: AppConstants.textInputDecoration
                          .copyWith(hintText: 'email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            } else {
                              setState(() => loading = false);
                              
                              print('user logged in successfully');
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    InkWell(
                      child: Text('Register'),
                      onTap: () => widget.toggleView(),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
