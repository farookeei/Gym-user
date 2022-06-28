import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/Kaimly/providers/authProvider.dart';
import 'package:gym_user/core/Validator/Validator.dart';
import 'package:gym_user/core/themes/gymData.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/allScreens.dart';
import 'package:gym_user/widgets/customBtn.dart';
import 'package:gym_user/widgets/customTextFormField.dart';
import 'package:gym_user/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Map<String, dynamic> _authData = {"email": "", "password": ""};

  login() async {
    // print(Kaimly.isLoggedIn);
    print(Kaimly.server.auth().access_token);
    // await Kaimly.server.login(email: 'admin@example.com', password: '8c2bdf8c');
  }

  readUser() {
    final user = Kaimly.server.auth();
    print(user.access_token);
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
          email: _authData['email'],
          password: _authData['password'],
          onlyThisRole: true,
          role: gymUserRole);
      setState(() => _isLoading = false);
      if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn) {
        Navigator.pushReplacementNamed(context, Dashboard.routeName);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      print(e);
      snackbar(context, "Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Text(
                    "\nLogin",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .merge(TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  CustomTextField(
                    validator: Validators.emailValidator,
                    onSaved: (e) {
                      _authData["email"] = e!.trim();
                    },
                    hinttext: "Email",
                  ),
                  CustomTextField(
                    // validator: Validators.passwordValidator,
                    isPassword: true,
                    onSaved: (e) {
                      _authData["password"] = e!.trim();
                    },
                    hinttext: "Password",
                  ),
                  CustomBtn(
                    isLoading: _isLoading,
                    label: "Login",
                    onPressed: () {
                      submit();
                    },
                    color: primaryColor,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Forgotten Password?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .merge(TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegistorScreen.routeName);
                    },
                    child: Text(
                      "Don't have account yet?\n",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .merge(TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  CustomBtn(
                    iconUrl: "assets/images/Bold/Calling.png",
                    color: textformfieldfillcolor,
                    label: "Call Gym",
                    labelColor: bodyText2,
                    onPressed: () {
                      readUser();
                    },
                    width: 200,
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
