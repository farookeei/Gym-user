import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:shimmer/shimmer.dart';

class CustomBarGraph extends StatefulWidget {
  final List<double> values;

  final double marginTop;
  final double marginBottom;
  final bool isBottomWidget;

  const CustomBarGraph({
    required this.values,
    this.isBottomWidget = false,
    this.marginBottom = 10,
    this.marginTop = 10,
  });

  @override
  _CustomBarGraphState createState() => _CustomBarGraphState();
}

class _CustomBarGraphState extends State<CustomBarGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: widget.marginTop, bottom: widget.marginBottom),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: basicShadow,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 200,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
              height: widget.isBottomWidget ? 150 : 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 16.0,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      margin: 10.0,
                      showTitles: true,
                      // rotateAngle: 35.0,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'MON';
                          case 1:
                            return 'TUE';
                          case 2:
                            return 'WED';
                          case 3:
                            return 'THU';
                          case 4:
                            return 'FRI';
                          case 5:
                            return 'SAT';
                          case 6:
                            return 'SUN';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      margin: 10.0,
                      showTitles: false,
                      interval: 20,
                      rotateAngle: 270,
                      getTitles: (value) {
                        if ("one".length == 3) {
                          return "Calories";
                        }
                        return "Calories";
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    drawHorizontalLine: false,
                    show: true,
                    // checkToShowHorizontalLine: (value) => value % 3 == 0,
                    // getDrawingHorizontalLine: (value) => FlLine(
                    //   color: Colors.black12,
                    //   strokeWidth: 1.0,
                    //   dashArray: [5],
                    // ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: widget.values
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          BarChartGroupData(
                            x: key,
                            barRods: [
                              BarChartRodData(
                                width: 30,
                                colors: [primaryColor],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5)),
                                y: value,
                              ),
                            ],
                          )))
                      .values
                      .toList(),
                ),
              ),
            ),
            widget.isBottomWidget
                ? Divider(
                    thickness: 1.2,
                  )
                : SizedBox.shrink(),
            widget.isBottomWidget
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 12, left: 12),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Text(
                              "Complete today's workout",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              "assets/images/Bold/Arrow - Right Circle.png",
                              scale: 1.5,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ));
  }
}

class ChartShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin:
      //     EdgeInsets.only(top: widget.marginTop, bottom: widget.marginBottom),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        boxShadow: basicShadow,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      height: 170,
      child: Shimmer.fromColors(
          baseColor: shimmerLine,
          highlightColor: Theme.of(context).accentColor,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  shimmerLines(context, width: 30, height: 20, bottomMargin: 0),
                  shimmerLines(context, width: 30, height: 40, bottomMargin: 0),
                  shimmerLines(context, width: 30, height: 60, bottomMargin: 0),
                  shimmerLines(context, width: 30, height: 80, bottomMargin: 0),
                  shimmerLines(context, width: 30, height: 90, bottomMargin: 0),
                  shimmerLines(context,
                      width: 30, height: 100, bottomMargin: 0),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: shimmerLines(context, bottomMargin: 0),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    shimmerLines(context, width: 30, bottomMargin: 0),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
