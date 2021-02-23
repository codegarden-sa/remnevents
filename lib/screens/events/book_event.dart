import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/constants/loading.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:date_field/date_field.dart';
import 'package:sandtonchurchapp/components/date_time_picker.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';


class BookEvent extends StatefulWidget {
  final Function toggleView;
  BookEvent({this.toggleView});

  @override
  _BookEventState createState() => _BookEventState();
}

class _BookEventState extends State<BookEvent> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  String title;
  String description;
  String department;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  String _dept;

  var departmentList = [
    {'display':'Pathfinders',
      'value': 'Pathfinders'
    },
    {'display':'Women Ministries',
      'value': 'Women Ministries'
    },
    {'display':'Stewardship',
      'value': 'Stewardship'
    },
    {'display':'Publishing',
      'value': 'Publishing'
    },
    {'display':'Adventist Men',
      'value': 'Adventist Men'
    },
    {'display':'Youth',
      'value': 'Youth'
    },
    {'display':'Adventures',
      'value': 'Adventures'
    },
    {'display':'Children Minitries',
      'value': 'Children Minitries'
    },
    {'display':'Welfare',
      'value': 'Welfare'
    },
    {'display':'YWM',
      'value': 'YWM'
    }
  ];

  // text field state
  @override
  void initState() {
    super.initState();

    title = '';
    description = '';
    department = '';
    startDate = '';
    endDate = '';
    startTime = '';
    endTime = '';
    _dept = '';
  }

  void setDateTime(
      String startDate, String startTime, String endDate, String endTime) {
    this.startDate = startDate;
    this.startTime = startTime;
    this.endDate = endDate;
    this.endTime = endTime;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : SingleChildScrollView(
            // backgroundColor: Colors.brown[100],
            // appBar: AppBar(
            //   backgroundColor: Colors.brown[400],
            //   elevation: 0.0,
            //   title: Text('Sign up to Brew Crew'),
            //   actions: <Widget>[
            //     FlatButton.icon(
            //       icon: Icon(Icons.person),
            //       label: Text('Sign In'),
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
                          .copyWith(hintText: 'Event Title'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter event title' : null,
                      onChanged: (val) {
                        setState(() => title = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: AppConstants.textInputDecoration
                          .copyWith(hintText: 'Event Description'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter event description' : null,
                      onChanged: (val) {
                        setState(() => description = val);
                      },
                    ),
                    // SizedBox(height: 20.0),
                    // TextFormField(
                    //   decoration: AppConstants.textInputDecoration
                    //       .copyWith(hintText: 'Department'),
                    //   validator: (val) =>
                    //       val.isEmpty ? 'Enter department' : null,
                    //   onChanged: (val) {
                    //     setState(() => department = val);
                    //   },
                    // ),
                    SizedBox(height: 20.0),

                                  Container(
                // padding: EdgeInsets.all(16),
                child: DropDownFormField(
                  titleText: 'Choose Department',
                  hintText: '',
                  value: _dept,
                  onSaved: (value) {
                    setState(() {
                      _dept = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _dept = value;
                    });
                  },
                  dataSource: [
    {'display':'Pathfinders',
      'value': 'Pathfinders'
    },
    {'display':'Women Ministries',
      'value': 'Women Ministries'
    },
    {'display':'Stewardship',
      'value': 'Stewardship'
    },
    {'display':'Publishing',
      'value': 'Publishing'
    },
    {'display':'Adventist Men',
      'value': 'Adventist Men'
    },
    {'display':'Youth',
      'value': 'Youth'
    },
    {'display':'Adventures',
      'value': 'Adventures'
    },
    {'display':'Children Minitries',
      'value': 'Children Minitries'
    },
    {'display':'Welfare',
      'value': 'Welfare'
    },
    {'display':'YWM',
      'value': 'YWM'
    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                ),
              ),

                    SizedBox(height: 20.0),
                    DateTimeFld(setDateTime: setDateTime),

                    // DateTimeFld(),
                    // TextFormField(
                    //   decoration: AppConstants.textInputDecoration
                    //       .copyWith(hintText: 'email'),
                    //   validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    //   onChanged: (val) {
                    //     setState(() => email = val);
                    //   },
                    // ),
                    // SizedBox(height: 20.0),
                    // TextFormField(
                    //   decoration: AppConstants.textInputDecoration
                    //       .copyWith(hintText: 'password'),
                    //   obscureText: true,
                    //   validator: (val) => val.length < 6
                    //       ? 'Enter a password 6+ chars long'
                    //       : null,
                    //   onChanged: (val) {
                    //     setState(() => password = val);
                    //   },
                    // ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: AppConstants.grey,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              department = _dept;
                            });
                            // setState(() => loading = true);
                            // dynamic res = await DatabaseService(uid: user.uid)
                            //     .bookEvent(title, description, department,
                            //         startDate, endDate, startTime, endTime);
                            print('results from submiting event');
                            print(user.uid);
                            print(department +
                                ' ' +
                                department +
                                ' ' +
                                startDate +
                                ' ' +
                                startTime +
                                ' ' +
                                endDate +
                                ' ' +
                                endTime);
                            // if (res == null) {
                            //   setState(() {
                            //     loading = false;
                            //     error = 'place holder for error';
                            //   });
                            // }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
