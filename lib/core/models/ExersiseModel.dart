import 'package:hive/hive.dart';

class ExerciseModel {
  final String id;
  final String status;
  final String dateCreated;
  final String name;
  final String description;
  final String image;

  ExerciseModel({
    required this.id,
    required this.status,
    required this.dateCreated,
    required this.name,
    required this.description,
    required this.image,
  });

  static ExerciseModel convert(Map data) {
    return ExerciseModel(
        id: data['id'],
        status: data['status'],
        dateCreated: data['date_created'],
        name: data['name'],
        description: data['description'],
        image: data['image']);
  }

  static List<ExerciseModel> convertlist(dynamic data) {
    dynamic _exercise = data['data'];
    List<ExerciseModel> exercise = [];
    for (var data in _exercise) {
      exercise.add(ExerciseModel.convert(data));
    }
    return exercise;
  }
}
