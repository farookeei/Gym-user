import 'package:gym_user/core/models/ExersiseModel.dart';
import 'package:hive/hive.dart';

class WorkoutDailyExerciseModel {
  final String id;
  final String status;
  final String dateCreated;
  final String day;
  final int time;
  final int count;
  final String cooldownTime;
  bool isdone;
  final ExerciseModel exercise;

  WorkoutDailyExerciseModel({
    required this.id,
    required this.status,
    required this.dateCreated,
    required this.day,
    required this.time,
    required this.count,
    required this.cooldownTime,
    required this.exercise,
    this.isdone = false,
  });

  static WorkoutDailyExerciseModel convert(Map data) {
    return WorkoutDailyExerciseModel(
      id: data['id'],
      status: data['status'],
      dateCreated: data['date_created'],
      day: data['day'],
      time: data['time'],
      count: data['count'],
      cooldownTime: data['cooldown_time'],
      exercise: ExerciseModel.convert(data['exercise']),
    );
  }

  static List<WorkoutDailyExerciseModel> convertlist(dynamic data) {
    dynamic _workouts = data['data'];
    List<WorkoutDailyExerciseModel> workouts = [];
    for (var data in _workouts) {
      workouts.add(WorkoutDailyExerciseModel.convert(data));
    }
    return workouts;
  }

  static List<WorkoutDailyExerciseModel> convertlistNoData(dynamic _workouts) {
    List<WorkoutDailyExerciseModel> workouts = [];
    try {
      for (var data in _workouts) {
        workouts.add(WorkoutDailyExerciseModel.convert(data));
      }
    } catch (e) {
      throw e;
    }
    return workouts;
  }
}
