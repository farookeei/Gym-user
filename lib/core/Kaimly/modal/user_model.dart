import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 200)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String first_name;
  @HiveField(2)
  final String last_name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String role;
  @HiveField(5)
  final String avatar;
  @HiveField(6)
  final String description;
  @HiveField(7)
  final String title;
  @HiveField(8)
  final String? workoutDoneTime;

  UserModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.role,
    required this.avatar,
    required this.description,
    required this.title,
    this.workoutDoneTime = null,
  });

  static UserModel convert(Map data) {
    Map user = data['data'];

    return UserModel(
      id: user['id'],
      first_name: user['first_name'] == null ? '' : user['first_name'],
      last_name: user['last_name'] == null ? '' : user['last_name'],
      email: user['email'],
      role: user['role'],
      avatar: user['avatar'] == null ? '' : user['avatar'],
      description: user['description'] == null ? '' : user['description'],
      title: user['title'] == null ? '' : user['title'],
    );
  }

  static UserModel convertNoData(Map user) {
    return UserModel(
      id: user['id'],
      first_name: user['first_name'] == null ? '' : user['first_name'],
      last_name: user['last_name'] == null ? '' : user['last_name'],
      email: user['email'],
      role: user['role'],
      avatar: user['avatar'] == null ? '' : user['avatar'],
      description: user['description'] == null ? '' : user['description'],
      title: user['title'] == null ? '' : user['title'],
    );
  }

  static List<UserModel> convertlist(dynamic data) {
    dynamic _users = data['data'];
    List<UserModel> users = [];
    for (var data in _users) {
      users.add(UserModel.convertNoData(data));
    }
    return users;
  }
}
