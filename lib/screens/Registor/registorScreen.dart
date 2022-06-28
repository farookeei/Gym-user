import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/providers/authProvider.dart';
import 'package:gym_user/core/Validator/Validator.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/customBtn.dart';
import 'package:gym_user/widgets/customImagePick.dart';
import 'package:gym_user/widgets/customTextFormField.dart';
import 'package:gym_user/widgets/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegistorScreen extends StatefulWidget {
  static const routeName = "/registor";

  @override
  _RegistorScreenState createState() => _RegistorScreenState();
}

String _filepicked = "";
File _file = File('0');
String _fileName = '';
bool _isLoading = false;

class _RegistorScreenState extends State<RegistorScreen> {
  final _picker = ImagePicker();

  Future<String> getFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return '';

    return pickedFile.path;
  }

  Future<void> _filepick() async {
    _filepicked = await getFile();
    setState(() {
      _file = File(_filepicked);
    });
    // filepicked = filePath;
    print(_filepicked);
    _fileName = _file.path.split("/").last;

    print(_file.toString());
  }

  @override
  void initState() {
    _fileName = '';
    super.initState();
  }

  Map<String, dynamic> _authData = {"email": "", "password": ""};
  String _confirmPassword = '';

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (_authData["password"] == _confirmPassword) {
      setState(() => _isLoading = true);
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .signup(email: _authData["email"], password: _authData["password"]);
        setState(() => _isLoading = false);
        snackbar(context, "User Created");
      } catch (e) {
        print(e);
        setState(() => _isLoading = false);
        snackbar(context, e.toString());
      }
    } else {
      snackbar(context, "passwords does not match");
    }
  }

  final _formKey = GlobalKey<FormState>();
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
                  Text(
                    "SignUp",
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
                    isPassword: true,
                    // validator: Validators.passwordValidator,
                    onSaved: (e) {
                      _authData["password"] = e!.trim();
                    },
                    hinttext: "Password",
                  ),
                  CustomTextField(
                    isPassword: true,
                    onSaved: (e) {
                      _confirmPassword = e!.trim();
                    },
                    hinttext: "Confirm Password",
                  ),
                  CustomBtn(
                    isLoading: _isLoading,
                    label: "Create Account",
                    onPressed: submit,
                    color: primaryColor,
                    height: 60,
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}









    // CustomTextField(
                  //   validator: Validators.emailValidator,
                  //   onSaved: (e) {
                  //     // _authData["email"] = e!.trim();
                  //   },
                  //   hinttext: "Email",
                  // ),
                  // CustomTextField(
                  //   // validator: Validators.passwordValidator,
                  //   isPassword: true,
                  //   onSaved: (e) {
                  //     // _authData["password"] = e!.trim();
                  //   },
                  //   hinttext: "DIstrict",
                  // ),
                  // CustomTextField(
                  //   // validator: Validators.passwordValidator,
                  //   isPassword: true,
                  //   onSaved: (e) {
                  //     // _authData["password"] = e!.trim();
                  //   },
                  //   hinttext: "pincode",
                  // ),
                  // CustomImagePick(
                  //   fileName: _fileName,
                  //   onTap: _filepick,
                  // ),
                  // CustomTextField(
                  //   // validator: Validators.passwordValidator,
                  //   isPassword: true,
                  //   keyboardType: TextInputType.number,
                  //   onSaved: (e) {
                  //     // _authData["password"] = e!.trim();
                  //   },
                  //   hinttext: "Age",
                  // ),
