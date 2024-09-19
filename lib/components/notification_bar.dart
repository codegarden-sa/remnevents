import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
// Remove unused import
import 'package:remnevents/constants/constants.dart';
import 'package:remnevents/models/event.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
// Add this import
class NotificationBar extends StatefulWidget {
  const NotificationBar({
    Key? key,
    required this.event,
    required this.updateSnackBar,
  }) : super(key: key);

  final EventModel event;
  final Function updateSnackBar;

  @override
  _NotificationBarState createState() => _NotificationBarState();
}
class _NotificationBarState extends State<NotificationBar> {
  final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();
  late DateTime _scheduledDateTime;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('sda_sandton');
    var initializationSettingsIOS = DarwinInitializationSettings(
        // ... iOS settings
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _initializeNotifications(initializationSettings);
  }

  Future<void> _initializeNotifications(InitializationSettings initializationSettings) async {
    await localNotification.initialize(initializationSettings);
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
    var androidDetails = AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.high);
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotification.zonedSchedule(
        widget.event.notificationId,
        widget.event.title,
        widget.event.description,
        tz.TZDateTime.from(_scheduledDateTime, tz.local),
        generalNotificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
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
              activeBgColors: [
                [AppConstants.darkblue],
                [AppConstants.darkblue],
                [AppConstants.darkblue]
              ],
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
                    print('it is clicked, to see futher into the code' +
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
