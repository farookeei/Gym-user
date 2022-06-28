import 'package:flutter/material.dart';

void snackbar(BuildContext context, String notification) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(notification),
    duration: Duration(seconds: 3),
  ));
}
