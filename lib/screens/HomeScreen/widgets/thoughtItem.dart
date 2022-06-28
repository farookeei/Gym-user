import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:shimmer/shimmer.dart';

class ThoughtItem extends StatelessWidget {
  const ThoughtItem({
    Key? key,
    required this.bywho,
    required this.isLoading,
    required this.thought,
  }) : super(key: key);

  final bool isLoading;
  final String bywho, thought;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return ThoughtShimmer();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: basicShadow,
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        clipBehavior: Clip.none,
        // overflow: Overflow.visible,
        children: [
          Positioned(
            left: -18,
            top: -32,
            child: Image.asset(
              "assets/images/Quote.png",
              height: 21,
            ),
          ),
          Text(
            thought,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .merge(TextStyle(fontWeight: FontWeight.w500)),
          ),
          Positioned(
            bottom: -20,
            right: 0,
            child: Text(
              bywho,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .merge(TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class ThoughtShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: basicShadow,
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        clipBehavior: Clip.none,
        // overflow: Overflow.visible,
        children: [
          Positioned(
            left: -18,
            top: -32,
            child: Image.asset(
              "assets/images/Quote.png",
              height: 21,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Shimmer.fromColors(
              child: shimmerLines(context, isFull: true),
              baseColor: shimmerLine,
              highlightColor: Theme.of(context).accentColor,
            ),
          ),
          Positioned(
            bottom: -20,
            right: 0,
            child: Shimmer.fromColors(
              child: shimmerLines(context, width: 100),
              baseColor: shimmerLine,
              highlightColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
