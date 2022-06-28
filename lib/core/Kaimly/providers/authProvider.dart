import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/Kaimly/dioService.dart';
import 'package:gym_user/core/Kaimly/modal/auth_model.dart';

class AuthProvider with ChangeNotifier {
  AuthModel? _authData;
  DioServicesAPI? dioServicesAPI;

  bool get isLoggedIn => _authData != null
      ? _authData!.access_token.isNotEmpty
          ? true
          : false
      : false;

  loadUserData() {
    AuthModel _auth = Kaimly.server.auth();
    _authData = _auth;
  }

  Future<void> login(
      {required String email,
      required String password,
      String role = '',
      bool onlyThisRole = false}) async {
    try {
      await Kaimly.server.login(
          email: email,
          password: password,
          role: role,
          onlyThisRole: onlyThisRole);
      _authData = await Kaimly.server.auth();
      print(_authData!.access_token.isNotEmpty);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> signup({required String email, required String password}) async {
    try {
      await Kaimly.server.createUser(email: email, password: password);
    } catch (e) {
      print("$e   in provider");
      throw e;
    }
  }

  logout() async {
    await Kaimly.server.logout();
    _authData = null;
    notifyListeners();
  }
}
