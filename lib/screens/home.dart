import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:sandtonchurchapp/firstscreen.dart';

import 'auth/auth.dart';
import '../calendar_events.dart';
import '../color_scheme.dart';
import '../ui/pages/add_event.dart';
import '../ui/view_event.dart';

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
    AddEventPage(),
    ListEvents()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.darkblue,
          selectedItemColor: AppColors.guava,
          unselectedItemColor: AppColors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: '',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          elevation: 4),
    );
  }
}
