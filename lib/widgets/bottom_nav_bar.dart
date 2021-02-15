import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/color_scheme.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.darkblue,
      selectedItemColor: Colors.white,
      unselectedItemColor: AppColors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, size: 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
            size: 30,
          ),
          label: 'All Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              size: 30),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: _onItemTap,
      elevation: 4
    );
  }
}
