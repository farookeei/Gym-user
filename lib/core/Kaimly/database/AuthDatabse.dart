import 'package:gym_user/core/Kaimly/modal/auth_model.dart';
import 'package:hive/hive.dart';

class AuthDatabase {
  static const boxname = 'authDatabase';

  Future<void> addData(AuthModel data) async {
    final _userBox = Hive.box(boxname);
    if (_userBox.isNotEmpty) _userBox.clear();
    await _userBox.add(data);
  }

  AuthModel? acessData() {
    final _userBox = Hive.box(boxname);
    if (_userBox.isEmpty) return null;
    return _userBox.getAt(0);
  }

  void deleteData() {
    final _userBox = Hive.box(boxname);
    _userBox.clear();
  }
}
