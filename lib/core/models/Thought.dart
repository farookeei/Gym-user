import 'package:hive/hive.dart';

class ThoughtModel {
  final String thought;
  final int id;
  final String by_who;

  ThoughtModel({
    required this.thought,
    required this.id,
    required this.by_who,
  });

  static ThoughtModel convert(Map data) {
    return ThoughtModel(
      thought: data['thought'],
      id: data['id'],
      by_who: data['by_who'],
    );
  }

  static List<ThoughtModel> convertlist(dynamic data) {
    dynamic _thoughts = data['data'];
    List<ThoughtModel> thoughts = [];
    for (var data in _thoughts) {
      thoughts.add(ThoughtModel.convert(data));
    }
    return thoughts;
  }
}
