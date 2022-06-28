import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

PreferredSizeWidget customAppbar(BuildContext context,
    {required String label}) {
  return AppBar(
    backgroundColor: scaffoldBg,
    elevation: 0,
    centerTitle: true,
    leadingWidth: 80,
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Image.asset(
        "assets/images/Bold/Arrow - Left 2.png",
        scale: 1.5,
      ),
    ),
    title: Text(
      label,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .merge(TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
    ),
  );
}
