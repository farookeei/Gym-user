import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:shimmer/shimmer.dart';

class PricingShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10)),
      child: Shimmer.fromColors(
        baseColor: shimmerLine,
        highlightColor: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const SizedBox(width: 10),
            Expanded(
              flex: 6,
              child: shimmerLines(context, isFull: true, bottomMargin: 0),
            ),
            const SizedBox(width: 40),
            Expanded(
                flex: 4,
                child: shimmerLines(context,
                    isFull: true, bottomMargin: 0.2, height: 30)),
          ],
        ),
      ),
    );
  }
}
