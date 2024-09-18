import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remnevents/screens/splash.dart';
import 'package:remnevents/services/auth.dart';
import 'package:remnevents/state/app_state.dart';
import 'constants/palette.dart';
import 'package:remnevents/models/user.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool debugEnableDeviceSimulator = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        ChangeNotifierProvider(create: (context) => AppState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Remnevents',
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Palette.darkOrange,
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Palette.darkBlue,
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
