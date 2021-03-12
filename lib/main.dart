import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/screens/home.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:sandtonchurchapp/state/app_state.dart';
import 'constants/palette.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sandtonchurchapp/models/user.dart';
// import 'package:device_simulator/device_simulator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool debugEnableDeviceSimulator = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthService().user),
        StreamProvider<UserDetails>.value(value: DatabaseService().userDetails),
        ChangeNotifierProvider(create: (context) => AppState())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Remnevents',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.muliTextTheme(),
          accentColor: Palette.darkOrange,
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: Palette.darkBlue,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
