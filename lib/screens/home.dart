import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sandtonchurchapp/components/date_time_picker.dart';
import 'package:sandtonchurchapp/screens/authenticate/profile.dart';
import 'package:sandtonchurchapp/screens/events/list_events.dart';
import 'package:sandtonchurchapp/screens/events/event_tile.dart';
import 'package:sandtonchurchapp/state/app_state.dart';
import 'calendar/calendar_events.dart';
import '../constants/constants.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'events/book_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Navigation(); //Scaffold(
  }
}

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();

  List<Widget> _widgetOptions = [
    CalendarEvents(),
    ListEvents(
      eventListType: AppConstants.APPROVED,
      listTitle: 'All Events',
    ),
    Profile(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        'channelId',
        'Local Notification',
        'Testing remnevents notification description, great strides!!',
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(
        0,
        'Test Remnevents',
        'The journey to heaven is afoot, thus get on board brethren',
        generalNotificationDetails);
  }

  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // final isLeader = Provider.of<AppState>(context).isLeader;
    return Scaffold(
      body: IndexedStack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppConstants.lightgrey,
        selectedItemColor: AppConstants.guava,
        unselectedItemColor: AppConstants.grey,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCalendar, size: 20),
            label: '____',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidListAlt,
              size: 20,
            ),
            label: '____',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser, size: 20),
            label: '____',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex <= 2 ? _selectedIndex : 0,
        onTap: _onItemTap,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Consumer<AppState>(builder: (context, appState, _) {
        return new Visibility(
          visible: appState.isLeader && _selectedIndex == 0,
          // child: NeumorphicButton(
          //   style: NeumorphicStyle(
          //       shape: NeumorphicShape.flat,
          //       boxShape: NeumorphicBoxShape.circle(),
          //       depth: -1,
          //       lightSource: LightSource.topLeft,
          //       color: AppConstants.grey),
          child: FloatingActionButton(
              // backgroundColor: AppConstants.guava.withOpacity(0.8),
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                _showNotification();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BookEvent()));
              }),
          // },
          // ),
        );
      }),
    );
  }

// FloatingActionButton myButton(){

// }

}
