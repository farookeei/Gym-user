import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:shimmer/shimmer.dart';

class WorkoutItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: basicShadow,
          borderRadius: BorderRadius.circular(10)),
      child: Shimmer.fromColors(
        baseColor: shimmerLine,
        highlightColor: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerLines(context, isFull: true),
                  shimmerLines(
                    context,
                    isFull: true,
                  ),
                  shimmerLines(context, width: 75, bottomMargin: 0),
                ],
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 4,
              child: shimmerLines(context,
                  isFull: true, radius: 10, height: 75, bottomMargin: 0),
            )
          ],
        ),
      ),
    );
  }
}
