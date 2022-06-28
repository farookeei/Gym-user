import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/MembershipModel.dart';

// enum GymScreens { Course, Pricing, Trainers, Equipments }
class GymScreens {
  static String course = 'Course';
  static String pricing = 'Pricing';
  static String trainers = 'Trainers';
  static String equipments = 'Equipments';
  static String gallery = 'Gallery';
  static getDefaultSelectedIn(String screen) {
    switch (screen) {
      case 'Course':
        return 0;
        break;
      case 'Pricing':
        return 1;
        break;
      case 'Trainers':
        return 2;
        break;
      case 'Equipments':
        return 3;
        break;
      case 'Gallery':
        return 4;
        break;
      default:
    }
  }
}

class RouteProvider with ChangeNotifier {
  late TabController controller;

  setController(TabController _controller) {
    controller = _controller;
    notifyListeners();
  }

  String gymScreen = GymScreens.course;
  setGymScreen(String screen) {
    gymScreen = screen;
    notifyListeners();
  }
}
