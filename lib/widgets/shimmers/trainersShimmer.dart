import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:shimmer/shimmer.dart';

class TrainerShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: shimmerLine,
            highlightColor: Theme.of(context).accentColor,
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 100,
                  child: shimmerLines(context,
                      isFull: true, height: 80, bottomMargin: 0.1),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      shimmerLines(
                        context,
                        isFull: true,
                      ),
                      shimmerLines(
                        context,
                        bottomMargin: 0,
                        isFull: true,
                      ),

                      // Row(
                      //   children: [
                      //     Image.asset(
                      //       "assets/images/insta.png",
                      //       scale: 1.3,
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Image.asset(
                      //       "assets/images/whatsapp.png",
                      //       scale: 1.3,
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
