import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:shimmer/shimmer.dart';

class TransactionShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            boxShadow: basicShadow,
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10)),
        child: Shimmer.fromColors(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerLines(context, width: 120, height: 21),
                  shimmerLines(context, width: 100, bottomMargin: 0)
                ],
              ),
              shimmerLines(context, width: 40, bottomMargin: 0)
            ],
          ),
          baseColor: shimmerLine,
          highlightColor: Theme.of(context).accentColor,
        ));
  }
}
