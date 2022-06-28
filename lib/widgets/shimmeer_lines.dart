import 'package:flutter/material.dart';

Widget shimmerLines(BuildContext context,
    {double width = 0,
    bool isFull = false,
    double radius = 5,
    double bottomMargin = 10,
    double height = 20}) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(radius)),
    margin: EdgeInsets.only(bottom: bottomMargin),
    padding: EdgeInsets.all(5),
    width: isFull ? double.infinity : width,
    height: height,
    child: const SizedBox(),
  );
}
