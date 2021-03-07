import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:sandtonchurchapp/models/event.dart';

class AdminBar extends StatelessWidget {
  final EventModel event;
  final Function updateSnackBar;
  AdminBar({Key key, this.event, this.updateSnackBar}) : super(key: key);

  int getState(String eventStatus) {
    int _idx = 0;
    switch (eventStatus) {
      case 'approved':
        _idx = 0;
        break;
      case 'pending':
        _idx = 1;
        break;
      case 'declined':
        _idx = 2;
        break;
      case 'deleted':
        _idx = 3;
        break;
      default:
        break;
    }
    return _idx;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 40),
        child: ToggleSwitch(
          minWidth: 60.0,
          initialLabelIndex: getState(event.status),
          activeBgColor: AppConstants.darkblue,
          activeFgColor: AppConstants.guava,
          inactiveBgColor: Colors.grey.withOpacity(0.7),
          inactiveFgColor: Colors.white54,
          labels: ['', '', '', ''],
          icons: [
            FontAwesomeIcons.solidThumbsUp,
            FontAwesomeIcons.clock,
            FontAwesomeIcons.solidThumbsDown,
            FontAwesomeIcons.trash,
          ],
          iconSize: 30.0,
          onToggle: (index) async {
            switch (index) {
              case 0:
                if (event.status != AppConstants.APPROVED) {
                  dynamic result = await DatabaseService()
                      .updateEvent(event.id, AppConstants.APPROVED);
                  print(result);
                  if (result == 'updated') updateSnackBar();
                }
                break;
              case 1:
                if (event.status != AppConstants.PENDING) {
                  dynamic result = await DatabaseService()
                      .updateEvent(event.id, AppConstants.PENDING);
                  print(result);
                  if (result == 'updated') updateSnackBar();
                }
                break;
              case 2:
                print('declined');
                break;
              case 3:
                print('deleted');
                break;
              default:
            }
          },
        ));
  }
}
