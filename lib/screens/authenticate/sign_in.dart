import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/constants/loading.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/state/app_state.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign In', style: TextStyle(color: AppConstants.darkblue, fontSize: 25),),
          ],
        ),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        ),
      ),
        backgroundColor: AppConstants.lightgrey,
        elevation: 0.0,
        
      ),
    
    body: loading
        ? Loading()
        : Padding(
         padding: const EdgeInsets.only(top: 30),
          child: Container(
                              padding: EdgeInsets.only(left: 25, right: 15),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.75,
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
                      // SizedBox(height: 12.0),
                      // Text(
                      //   error,
                      //   style: TextStyle(color: Colors.red, fontSize: 14.0),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Text('Register', style: TextStyle(color: AppConstants.lightgrey, fontSize: 18),),
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
