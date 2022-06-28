import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:shimmer/shimmer.dart';

class EquipmentShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: basicShadow,
          color: Theme.of(context).accentColor),
      child: Shimmer.fromColors(
          baseColor: shimmerLine,
          highlightColor: Theme.of(context).accentColor,
          child: Column(
            children: [
              shimmerLines(context,
                  radius: 4, isFull: true, height: 120, bottomMargin: 10),
              Expanded(
                  child: shimmerLines(context,
                      radius: 2, isFull: true, height: 40, bottomMargin: 0)),
            ],
          )),
    );
  }
}
