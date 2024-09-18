import 'package:flutter/material.dart';
import 'package:remnevents/constants/loading.dart';
import 'package:remnevents/constants/constants.dart';
import 'package:remnevents/services/database.dart';
import 'package:provider/provider.dart';
import 'package:remnevents/models/user.dart';
import 'package:remnevents/components/date_time_picker.dart';
import 'package:remnevents/components/date_selector.dart';
import 'package:direct_select_flutter/direct_select_container.dart';

class BookEvent extends StatefulWidget {
  final Function toggleView;
  final Function home;

  const BookEvent({
    Key? key, 
    required this.toggleView, 
    required this.home
  }) : super(key: key);

  @override
  _BookEventState createState() => _BookEventState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class _BookEventState extends State<BookEvent> {
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  late String title;
  late String description;
  late String department;
  late DateTime startDate;
  late DateTime endDate;
  late String _dept;
  int departmentIndex = 0;

  List<String> _departments = [
    'Department',
    'Pathfinders',
    'Adventist Women',
    'Health',
    'Steward',
    'Publishing',
    'Sabbath School',
    'Adventist Youth',
    'Adventures',
    'Children',
    'Welfare',
    'Leadership',
    'Education',
    'Possibilities',
    'MAD',
    'Media & Comms',
    'YAWM',
    'AMO',
    'Religious Liberty'
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

  void getDepartmentValue(String value) {
    if (value != 'Department') {
      _dept = value;
      departmentIndex = _departments.indexOf(value);
    }
    //workaround to prevent the selector from defaulting to the first value index
    departmentIndex = _departments.indexOf(value);
  }

  final snackBar = SnackBar(content: Text('Booking submitted'));

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstants.lightgrey,
        ),
        title: Text(
          'Book Event',
          style: TextStyle(color: AppConstants.lightgrey, fontSize: 25),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.0),
          ),
        ),
        backgroundColor: AppConstants.darkblue,
        elevation: 0.0,
      ),
      body: loading
          ? Loading()
          : Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _formKey,
                    child: DirectSelectContainer(
                      child: Column(
                        children: <Widget>[
                          DepartmentSelector(
                            data: _departments,
                            label: "",
                            getDepartmentValue: getDepartmentValue,
                            departmentIndex: departmentIndex,
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration: AppConstants.shadowDecoration,
                            child: TextFormField(
                              decoration: AppConstants.textInputDecoration
                                  .copyWith(hintText: 'Event Title'),
                              validator: (val) =>
                                  val?.isEmpty == true ? 'Enter event title' : null,
                              onChanged: (val) {
                                setState(() => title = val);
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration: AppConstants.shadowDecoration,
                            child: TextFormField(
                              decoration: AppConstants.textInputDecoration
                                  .copyWith(
                                      hintText: 'Event Description',
                                      contentPadding: new EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 10.0)),
                              validator: (val) => val?.isEmpty == true
                                  ? 'Enter event description'
                                  : null,
                              onChanged: (val) {
                                setState(() => description = val);
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          DateTimeFld(setDateTime: setDateTime),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.grey,
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  _dept.isNotEmpty) {
                                setState(() {
                                  department = _dept;
                                  loading = true;
                                });
                                try {
                                  await DatabaseService(uid: user.uid)
                                      .bookEvent(title, description,
                                          department, startDate, endDate);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                } catch (e) {
                                  print('Could not book event: $e');
                                } finally {
                                  setState(() {
                                    loading = false;
                                    description = '';
                                  });
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                          Column(
                            children: <Widget>[
                              // Container(
                              //   color: Colors.white,
                              //   // padding: EdgeInsets.all(16),
                              //   child: DropDownFormField(
                              //     titleText: 'Department',
                              //     hintText: 'Choose One',
                              //     validator: (val) =>
                              //         val.isEmpty ? 'Choose department' : null,
                              //     value: _dept,
                              //     onSaved: (value) {
                              //       setState(() {
                              //         _dept = value;
                              //       });
                              //     },
                              //     onChanged: (value) {
                              //       setState(() {
                              //         _dept = value;
                              //       });
                              //     },
                              //     dataSource: _departmentList,
                              //     textField: 'display',
                              //     valueField: 'value',
                              //   ),
                              // ),
                              // Department(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
