import 'package:gym_user/core/models/WorkoutDailyExerciseModel.dart';
import 'package:hive/hive.dart';

class WorkoutModel {
  final String id;
  final String name;
  final String description;
  final String level;
  final String image;
  final List<WorkoutDailyExerciseModel> workout_daily_exercise;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.image,
    required this.workout_daily_exercise,
  });

  static WorkoutModel convert(Map data) {
    print(data);
    return WorkoutModel(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      level: data['level'],
      image: data['image'] != null ? data['image'] : '',
      workout_daily_exercise: WorkoutDailyExerciseModel.convertlistNoData(
          data['workout_daily_exercise']),
    );
  }

  static List<WorkoutModel> convertlist(dynamic data) {
    dynamic _workouts = data['data'];
    List<WorkoutModel> workouts = [];
    for (var data in _workouts) {
      workouts.add(WorkoutModel.convert(data));
    }
    return workouts;
  }
}
