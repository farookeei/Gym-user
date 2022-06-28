import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/MembershipModel.dart';
import 'package:gym_user/core/models/WorkoutDailyExerciseModel.dart';
import 'package:gym_user/core/models/WorkoutModel.dart';

class MembershipProvider with ChangeNotifier {
  MembershipModel? membership;
  bool isLoadingMemberShip = true;

  loadMemberShip() async {
    try {
      isLoadingMemberShip = true;
      // notifyListeners();
      final _membership = await Kaimly.server
          .items(collection: 'user_plan_validity', fields: 'fields=*.*.*.*');
      // print(_membership);
      // print(Kaimly.server.auth().access_token);
      // print(_membership['data'][0]['current_workout']);
      membership = MembershipModel.convert(_membership['data'][0]);
      isLoadingMemberShip = false;
      notifyListeners();
      loadtodaysDailyWorkout();
    } catch (e) {
      // loadMemberShip();
      throw e;
    }
  }

  nextDayWorkout(int currentWorkoutDay) async {
    try {
      print(currentWorkoutDay);
      isLoadingMemberShip = true;
      Map<String, dynamic> _body = {"currentworkoutday": currentWorkoutDay + 1};
      print(_body);
      final fetchData = await Kaimly.server.updateitem(
        collection: "user_plan_validity",
        id: membership!.id,
        fields: 'fields=*.*.*.*',
        body: _body,
      );
      isLoadingMemberShip = false;
      notifyListeners();
      loadMemberShip();
    } catch (e) {}
  }

  // previousDay(int currentWorkoutDay) async {
  //   try {
  //     print(currentWorkoutDay);
  //     isLoadingMemberShip = true;
  //     Map<String, dynamic> _body = {"currentworkoutday": currentWorkoutDay - 1};
  //     print(_body);
  //     final fetchData = await Kaimly.server.updateitem(
  //       collection: "user_plan_validity",
  //       id: membership!.id,
  //       fields: 'fields=*.*.*.*',
  //       body: _body,
  //     );
  //     isLoadingMemberShip = false;
  //     notifyListeners();
  //     loadMemberShip();
  //   } catch (e) {}
  // }

  List<WorkoutDailyExerciseModel> todaysworkouts = [];
  int currentDailyExercisePosition = 0;

  loadtodaysDailyWorkout() {
    currentDailyExercisePosition = 0;
    List<WorkoutDailyExerciseModel> workouts = [];

    for (var dailyworkout
        in membership!.currentWorkout.workout_daily_exercise) {
      if (dailyworkout.day == membership!.currentworkoutday.toString()) {
        workouts.add(dailyworkout);
      }
    }

    bool _isfoundCurrent = false;
    int _i = 0;
    for (var dailtworkout in workouts) {
      if (membership!.last_done_daily_workout == null) {
        break;
      }
      if (dailtworkout.id != membership!.last_done_daily_workout!.id) {
        dailtworkout.isdone = true;
      }
      if (dailtworkout.id == membership!.last_done_daily_workout!.id &&
          !_isfoundCurrent) {
        dailtworkout.isdone = true;
        _isfoundCurrent = true;
        currentDailyExercisePosition = _i;
        break;
      }
      _i++;
    }
    if (_i + 1 == workouts.length) {
      currentDailyExercisePosition = _i + 1;
    }

    // workouts.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

    todaysworkouts = workouts;
    notifyListeners();
  }

  finishAworkoutDailyExercise(WorkoutDailyExerciseModel _dailyWorkoutitem) {
    List<WorkoutDailyExerciseModel> _workouts = todaysworkouts;

    bool _isfoundCurrent = false;
    int _i = 0;
    for (var dailtworkout in _workouts) {
      if (membership!.last_done_daily_workout == null) {
        membership!.last_done_daily_workout = _dailyWorkoutitem;
      }
      if (dailtworkout.id != _dailyWorkoutitem.id) {
        dailtworkout.isdone = true;
      }
      if (dailtworkout.id == _dailyWorkoutitem.id && !_isfoundCurrent) {
        dailtworkout.isdone = true;
        _isfoundCurrent = true;
        if (_i + 1 < _workouts.length) {
          currentDailyExercisePosition = _i + 1;
        }
        if (_i + 1 == _workouts.length) {
          currentDailyExercisePosition = _i + 1;
        }
        updatedailyworkoutinserver(_dailyWorkoutitem.id);
        break;
      }
      _i++;
    }

    todaysworkouts = _workouts;
    notifyListeners();
  }

  updatedailyworkoutinserver(String id) async {
    try {
      await Kaimly.server.updateitem(
          collection: 'user_plan_validity',
          id: membership!.id,
          body: {'last_done_daily_workout': id});
    } catch (e) {
      updatedailyworkoutinserver(id);
      throw e;
    }
  }
}
