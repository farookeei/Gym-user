import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final Color borderColor;
  final Function onTap;
  final Color bgColor;
  final double borderRadius;

  CustomOutlineButton(
      {required this.borderColor,
      required this.bgColor,
      this.borderRadius = 24,
      required this.onTap,
      required this.label,
      required this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
            horizontal: 22,
          )),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(color: borderColor)))),
      onPressed: () => onTap(),
      child: Text(label, style: labelStyle),
    );
  }
}
