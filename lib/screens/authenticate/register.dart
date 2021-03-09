import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/constants/loading.dart';
import 'package:sandtonchurchapp/constants/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  String surname = '';
  String cell = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Register', style: TextStyle(color: AppConstants.darkblue, fontSize: 25),),
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
    
    body: loading ? Loading() : Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
         padding: EdgeInsets.only(left: 25, right: 25),
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
            children: <Widget>[
                             SizedBox(height: 40.0),
                    TextFormField(
                      decoration: AppConstants.textInputDecoration
                          .copyWith(hintText: 'name'),
                      validator: (val) => val.isEmpty ? 'Enter your name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: AppConstants.textInputDecoration
                          .copyWith(hintText: 'surname'),
                      validator: (val) => val.isEmpty ? 'Enter your surname' : null,
                      onChanged: (val) {
                        setState(() => surname = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: AppConstants.textInputDecoration
                          .copyWith(hintText: 'cell'),
                      // validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => cell = val);
                      },
                    ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: AppConstants.textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: AppConstants.textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: AppConstants.grey,
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(name, surname, cell,email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                }
              ),
              // SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              InkWell(child: Text('Sign In',style: TextStyle(color: AppConstants.lightgrey, fontSize: 18)), onTap: () => widget.toggleView(),)
            ],
          ),
        ),
      ),
    ));
  }
}