import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/state/app_state.dart';

class EmptyDayEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDayEventsEmpty = Provider.of<AppState>(context).isDayEventsEmpty;

    if (isDayEventsEmpty) {
      return Container(
        color: Colors.yellow,
        child: Text('Nothing For Today'),
      );
    } else {
      return Container(color: Colors.white , child: Text('EMPTY'));
    }
  }
}
