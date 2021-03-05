import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/screens/home.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/constants/loading.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:date_field/date_field.dart';
import 'package:sandtonchurchapp/components/date_time_picker.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:sandtonchurchapp/components/libraries/dropdown_formfield.dart';

class BookEvent extends StatefulWidget {
  final Function toggleView;
  final Function home;

  BookEvent({this.toggleView, this.home});

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
  DateTime startDate;
  DateTime endDate;
  String _dept;

  var _departmentList = [
    {'display': 'Pathfinders', 'value': 'Pathfinders'},
    {'display': 'Women Ministries', 'value': 'Women Ministries'},
    {'display': 'Stewardship', 'value': 'Stewardship'},
    {'display': 'Publishing', 'value': 'Publishing'},
    {'display': 'Adventist Men', 'value': 'Adventist Men'},
    {'display': 'Youth', 'value': 'Youth'},
    {'display': 'Adventures', 'value': 'Adventures'},
    {'display': 'Children Minitries', 'value': 'Children Minitries'},
    {'display': 'Welfare', 'value': 'Welfare'},
    {'display': 'YWM', 'value': 'YWM'}
  ];

  // text field state
  @override
  void initState() {
    super.initState();

    title = '';
    description = '';
    department = '';
    _dept = '';
  }

  void setDateTime(DateTime startDate, DateTime endDate) {
    this.startDate = startDate;
    this.endDate = endDate;
  }

  final snackBar = SnackBar(content: Text('Booking submitted'));

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Event', style: TextStyle(color: Colors.white54),),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        ),
      ),
        backgroundColor: AppConstants.darkblue,
        elevation: 0.0,
        
      ),
      body: SafeArea(
              child: loading
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
                        Container(
                          color: Colors.white,
                          // padding: EdgeInsets.all(16),
                          child: DropDownFormField(
                            titleText: 'Department',
                            hintText: 'Choose One',
                            validator: (val) =>
                                val.isEmpty ? 'Choose department' : null,
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
                            dataSource: _departmentList,
                            textField: 'display',
                            valueField: 'value',
                          ),
                        ),
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
                        SizedBox(height: 20.0),
                        DateTimeFld(setDateTime: setDateTime),
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
                                setState(() => loading = true);
                                dynamic eventBooked =
                                    await DatabaseService(uid: user.uid)
                                        .bookEvent(title, description, department,
                                            startDate, endDate);
                                setState(() {
                                  loading = false;
                                  description = '';
                                });
                  
                                if (eventBooked != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else
                                  print('could not book event');
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
              ),
      ),
    );
  }
}
