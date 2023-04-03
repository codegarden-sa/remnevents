import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remnevents/screens/authenticate/profile.dart';
import 'package:remnevents/screens/events/list_events.dart';
import 'package:remnevents/screens/settings.dart';
import 'package:remnevents/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calendar/calendar_events.dart';
import '../constants/constants.dart';
import 'package:provider/provider.dart';
import 'events/book_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  // static MaterialPageRoute get route => MaterialPageRoute(
  //       builder: (context) => const HomeScreen(),
  //     );

  @override
  Widget build(BuildContext context) {
    return Navigation(); //Scaffold(
  }
}

class Navigation extends StatefulWidget {
  Navigation({
    Key key,
  });
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    CalendarEvents(),
    ListEvents(
      eventListType: AppConstants.APPROVED,
      listTitle: 'All Events',
    ),
    Settings(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final isLeader = Provider.of<AppState>(context, listen: true).isLeader;
    if (isLeader)
      print('::HOME:: this user is a leader ::');
    else
      print('::HOME:: not a leader at all hey');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //cond resizeToAvoidBottomPadding: false,
      body: IndexedStack(
        // sizing: StackFit.passthrough,
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
          visible: isLeader && _selectedIndex == 0,
          child: FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookEvent()));
              }),
        );
      }),
    );
  }
}
