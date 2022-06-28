import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double radiusTL;
  final double radiusTR;
  final double radiusBL;
  final double radiusBR;
  final double height;
  final Color color;
  final Color labelColor;
  final double width;
  final bool isLoading;
  final String iconUrl;

  CustomBtn(
      {required this.label,
      required this.onPressed,
      required this.color,
      this.radiusBL = 8,
      this.radiusBR = 8,
      this.radiusTL = 8,
      this.radiusTR = 8,
      this.height = 0,
      this.iconUrl = '',
      this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
      this.labelColor = Colors.white,
      this.width = double.infinity,
      this.isLoading = false});

  final EdgeInsets padding, margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == 0 ? null : height,
      // padding: EdgeInsets.all(13),
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radiusBL),
          bottomRight: Radius.circular(radiusBR),
          topLeft: Radius.circular(radiusTL),
          topRight: Radius.circular(radiusTR),
        ),
      ),
      child: TextButton.icon(
        icon: iconUrl == ''
            ? SizedBox.shrink()
            : Image.asset(
                iconUrl,
                height: 24,
                width: 24,
              ),
        label: isLoading
            ? CircularProgressIndicator()
            : Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).accentTextTheme.bodyText1!.merge(
                    TextStyle(fontWeight: FontWeight.w700, color: labelColor)),
              ),
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        ),
      ),
    );
  }
}
