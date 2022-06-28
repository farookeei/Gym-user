import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.hinttext = "",
      required this.onSaved,
      this.validator,
      this.initialVal,
      this.isPassword = false,
      this.maxlines = 1,
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
      this.keyboardType = TextInputType.text});

  final String hinttext;
  final String? initialVal;
  final bool isPassword;
  final EdgeInsets padding, margin;
  final int maxlines;
  final String? Function(String?)? validator;
  final void Function(String?) onSaved;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final BorderRadius _borderRadius = BorderRadius.all(Radius.circular(10));
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: basicShadow,
      ),
      child: TextFormField(
        maxLines: maxlines,
        initialValue: initialVal,
        validator: validator,
        obscureText: isPassword ? true : false,
        keyboardType: keyboardType,
        onSaved: onSaved,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            filled: true,
            fillColor: textformfieldfillcolor,
            hintStyle: TextStyle(fontSize: 14),
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 26),
            hintText: hinttext,
            border: OutlineInputBorder(
                borderRadius: _borderRadius, borderSide: BorderSide.none)),
      ),
    );
  }
}
