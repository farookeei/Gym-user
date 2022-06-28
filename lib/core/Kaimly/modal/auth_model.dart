import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 199)
class AuthModel {
  @HiveField(0)
  final String access_token;
  @HiveField(1)
  final int expires;
  @HiveField(2)
  final String refresh_token;

  AuthModel({
    required this.access_token,
    required this.expires,
    required this.refresh_token,
  });

  static AuthModel convert(Map data) {
    Map user = data['user'];

    return AuthModel(
      access_token: user['access_token'],
      expires: data['expires'],
      refresh_token: user['refresh_token'],
    );
  }
}
