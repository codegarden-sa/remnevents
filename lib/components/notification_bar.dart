import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remnevents/constants/constants.dart';
import 'package:remnevents/models/event.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationBar extends StatefulWidget {
  NotificationBar({Key key, this.event, this.updateSnackBar}) : super(key: key);
  final EventModel event;
  final Function updateSnackBar;

  @override
  _NotificationBarState createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> {
  final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();
  DateTime _scheduledDateTime;

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('sda_sandton');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {});
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    localNotification.initialize(initializationSettings);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  Future _scheduleNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        'channelId', 'Local Notification', 'Local Channel',
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotification.schedule(
        widget.event.notificationId,
        widget.event.title,
        widget.event.description,
        _scheduledDateTime,
        generalNotificationDetails);
  }

  int getState(int nTime) {
    int _idx = 0;
    switch (nTime) {
      case 1:
        _idx = 0;
        break;
      case 2:
        _idx = 1;
        break;
      case 24:
        _idx = 2;
        break;
      default:
        _idx = -1;
        break;
    }
    return _idx;
  }

  @override
  Widget build(BuildContext context) {
    print(':: notification bar :: incoming event ');
    print(widget.event.notificationId);
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text('Scheduled Reminder'),
            ToggleSwitch(
              minWidth: 60.0,
              initialLabelIndex: getState(widget.event.notificationTime),
              activeBgColor: AppConstants.darkblue,
              activeFgColor: AppConstants.guava,
              inactiveBgColor: Colors.grey.withOpacity(0.7),
              inactiveFgColor: Colors.white,
              labels: ['1hr', '2hr', '24hr'],
              // icons: [
              //   FontAwesomeIcons.clock,
              //   FontAwesomeIcons.clock,
              //   FontAwesomeIcons.clock,
              // ],
              iconSize: 30.0,
              onToggle: (index) async {
                switch (index) {
                  case 0:
                    print('it is clicked ...' +
                        widget.event.notificationId.toString());
                    if (widget.event.startDate.isAfter(DateTime.now()) &&
                        widget.event.status == AppConstants.APPROVED) {
                      _scheduledDateTime =
                          widget.event.startDate.subtract(Duration(hours: 1));
                      // _scheduledDateTime =
                      //     DateTime.now().add(Duration(seconds: 5));
                      _scheduleNotification();
                      print('time for event => ' +
                          widget.event.startDate.toString());
                      print('schedule time 1hr => ' +
                          _scheduledDateTime.toString());
                      widget.updateSnackBar('1hr Reminder Scheduled');
                    }
                    break;
                  case 1:
                    if (widget.event.startDate.isAfter(DateTime.now()) &&
                        widget.event.status == AppConstants.APPROVED) {
                      _scheduledDateTime =
                          widget.event.startDate.subtract(Duration(hours: 2));
                      _scheduleNotification();
                      print('time for event => ' +
                          widget.event.startDate.toString());
                      print('schedule time 1hr => ' +
                          _scheduledDateTime.toString());
                      widget.updateSnackBar('2hr Reminder Scheduled');
                    }
                    break;
                  case 2:
                    if (widget.event.startDate.isAfter(DateTime.now()) &&
                        widget.event.status == AppConstants.APPROVED) {
                      _scheduledDateTime =
                          widget.event.startDate.subtract(Duration(hours: 24));
                      _scheduleNotification();
                      print('time for event => ' +
                          widget.event.startDate.toString());
                      print('schedule time 1hr => ' +
                          _scheduledDateTime.toString());
                      widget.updateSnackBar('24hr Reminder Scheduled');
                    }
                    break;
                  default:
                    break;
                }
              },
            ),
          ],
        ));
  }
}
