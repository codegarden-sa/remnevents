import 'package:flutter/material.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:sandtonchurchapp/components/date_selector.dart';

class Department extends StatefulWidget {
  Department({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DepartmentState createState() => _DepartmentState();
}
  List<String> _departments = [
  'Pathfinders',
  'Adventist Women',
  'Health'
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

class _DepartmentState extends State<Department> {


  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: appBar,
      key: scaffoldKey,
      body: DirectSelectContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      DepartmentSelector(data: _departments, label: "Department"),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


