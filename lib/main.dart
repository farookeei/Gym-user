import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/Kaimly/database/database_conf.dart';
import 'package:gym_user/core/Kaimly/providers/authProvider.dart';
import 'package:gym_user/core/providers/provider_list.dart';
import 'package:gym_user/core/routes/routes.dart';
import 'package:gym_user/core/themes/gymData.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/onboard/onboardScreen.dart';
import 'package:gym_user/screens/sample/sample.dart';
import 'package:provider/provider.dart';
import 'screens/allScreens.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  Kaimly.init(baseUrl: 'https://tea.apphost.kaimly.com/');

  await hiveInitalSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: providers(),
      child: MaterialApp(
        routes: routes(),
        debugShowCheckedModeBanner: false,
        title: gymName,
        theme: themes(),
        home: Consumer<AuthProvider>(
          builder: (context, _authProvider, child) {
            _authProvider.loadUserData();
            return _authProvider.isLoggedIn ? Dashboard() : OnboardScreen();
          },
        ),
        // home: Kaimly.server.auth().access_token != ''
        // home: Kaimly.isLoggedIn ? Dashboard() : LoginScreen(),
      ),
    );
  }
}
