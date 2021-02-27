import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sandtonchurchapp/components/date_time_picker.dart';
import 'package:sandtonchurchapp/screens/authenticate/profile.dart';
import 'package:sandtonchurchapp/state/user_state.dart';
import 'calendar/calendar_events.dart';
import '../constants/constants.dart';
import 'events/view_event.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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

  List<Widget> _widgetOptions = [
    CalendarEvents(),
    ListEvents(),
    Profile(),
    BookEvent()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final isLeader = Provider.of<UserState>(context).isLeader;
    print('home widget, check isLeader ' + isLeader.toString());
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
        floatingActionButton: new Visibility(
          visible: isLeader && _selectedIndex == 0,
          child: NeumorphicButton(
            style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 6,
                lightSource: LightSource.topLeft,
                color: AppConstants.grey),
            child: NeumorphicIcon(Icons.add, size: 30),
            onPressed: () => _onItemTap(3),
          ),
        ));
  }

// FloatingActionButton myButton(){

// }

}
