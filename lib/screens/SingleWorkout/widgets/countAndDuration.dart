import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

class CountsAndDuration extends StatelessWidget {
  const CountsAndDuration(
      {Key? key, required this.count, required this.duration})
      : super(key: key);
  final int count, duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          // color: changeBtn,
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(50), topRight: Radius.circular(50))
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DetalisTile(
            label: "Count",
            count: "$count",
          ),
          DetalisTile(
            label: "Time",
            count: "$duration sec",
          ),
        ],
      ),
    );
  }
}

class DetalisTile extends StatelessWidget {
  final String label;
  final String count;

  DetalisTile({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).accentTextTheme.headline6,
        ),
        Text(
          count,
          style: Theme.of(context).accentTextTheme.bodyText1,
        )
      ],
    );
  }
}
