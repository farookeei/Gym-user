import 'package:flutter/material.dart';
import 'package:gym_user/screens/allScreens.dart';
import 'package:gym_user/screens/transcations/transactionDetail.dart';

Map<String, WidgetBuilder> routes() {
  return {
    LoginScreen.routeName: (ctx) => LoginScreen(),
    Profile.routeName: (ctx) => Profile(),
    Dashboard.routeName: (ctx) => Dashboard(),
    Gym.routeName: (ctx) => Gym(),
    Workout.routeName: (ctx) => Workout(),
    HomeScreen.routeName: (ctx) => HomeScreen(),
    QrScan.routeName: (ctx) => QrScan(),
    SingleWorkout.routeName: (ctx) => SingleWorkout(),
    PricingDetails.routeName: (ctx) => PricingDetails(),
    About.routename: (ctx) => About(),
    Transaction.routeName: (ctx) => Transaction(),
    RegistorScreen.routeName: (ctx) => RegistorScreen()
  };
}
