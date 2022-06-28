import 'package:gym_user/core/models/WorkoutDailyExerciseModel.dart';
import 'package:gym_user/core/models/WorkoutModel.dart';

class MembershipModel {
  final String id;
  final String validTill;
  final DateTime validTillDate;
  final DateTime date_updated;
  final String startingtime;
  final String endingtime;
  final int days_count;
  final int currentworkoutday;
  final WorkoutModel currentWorkout;
  WorkoutDailyExerciseModel? last_done_daily_workout;

  MembershipModel({
    required this.id,
    required this.validTill,
    required this.validTillDate,
    required this.date_updated,
    required this.startingtime,
    required this.endingtime,
    required this.days_count,
    required this.currentWorkout,
    required this.currentworkoutday,
    this.last_done_daily_workout,
  });

  static MembershipModel convert(Map data) {
    return MembershipModel(
      days_count: data['days_count'],
      validTill: data['valid_till'],
      id: data['id'],
      startingtime: data['startingtime'],
      endingtime: data['endingtime'],
      date_updated: DateTime.parse(data['date_updated']),
      validTillDate: DateTime.parse(data['valid_till']),
      currentWorkout: WorkoutModel.convert(data['current_workout']),
      currentworkoutday: data['currentworkoutday'],
      last_done_daily_workout: data['last_done_daily_workout'] != null
          ? WorkoutDailyExerciseModel.convert(data['last_done_daily_workout'])
          : null,
    );
  }

  static List<MembershipModel> convertlist(dynamic data) {
    dynamic _membershihp = data['data'];
    List<MembershipModel> membershihp = [];
    for (var data in _membershihp) {
      membershihp.add(MembershipModel.convert(data));
    }
    return membershihp;
  }
}
