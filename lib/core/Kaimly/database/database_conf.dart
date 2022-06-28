import 'dart:io';

import 'package:gym_user/core/Kaimly/database/AuthDatabse.dart';
import 'package:gym_user/core/Kaimly/database/UserDatabase.dart';
import 'package:gym_user/core/Kaimly/modal/auth_model.dart';
import 'package:gym_user/core/Kaimly/modal/user_model.dart';
import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart' as path_Provider;

hiveInitalSetup() async {
  // final appDocumnetDirectory =
  //     await path_Provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(AuthModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.initFlutter();
  // Hive.init(appDocumnetDirectory.path);
  await Hive.openBox(AuthDatabase.boxname);
  await Hive.openBox(UserDatabase.boxname);
}
