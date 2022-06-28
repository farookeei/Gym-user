import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/WorkoutDailyExerciseModel.dart';
import 'package:gym_user/core/providers/membershipProvider.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/allScreens.dart';
import 'package:gym_user/widgets/currentWorkout.dart';
import 'package:gym_user/widgets/customBtn.dart';

import 'package:gym_user/widgets/customGraph.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Workout extends StatefulWidget {
  static const routeName = "/workout";

  @override
  _WorkoutState createState() => _WorkoutState();
}

bool _isPause = false;
bool _isStart = true;

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrentWorkout(),
            // CustomBarGraph(
            //   marginBottom: 20,
            //   values: [10, 8, 4, 6, 9, 4.5, 4],
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Today's Workouts",
                      style: Theme.of(context).textTheme.headline6!.merge(
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    ),
                    Consumer<MembershipProvider>(
                        builder: (ctx, memberShipData, _) {
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        decoration: BoxDecoration(
                          color: textformfieldShadowcolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Day ${memberShipData.membership!.currentworkoutday}',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1!
                              .merge(
                                TextStyle(fontSize: 12),
                              ),
                        ),
                      );
                    })
                  ],
                ),

                //!checking whther daily workout finished
                Consumer<MembershipProvider>(builder: (ctx, membershipData, _) {
                  if (membershipData.todaysworkouts.length == 0) {
                    return SizedBox();
                  }
                  if (membershipData.currentDailyExercisePosition ==
                      membershipData.todaysworkouts.length) {
                    return InkWell(
                      onTap: () {
                        Provider.of<MembershipProvider>(context, listen: false)
                            .nextDayWorkout(
                                membershipData.membership!.currentworkoutday);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Next day ",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .accentTextTheme
                                  .bodyText1!
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Icon(
                              Icons.fast_forward_rounded,
                              color: Theme.of(context).accentColor,
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(SingleWorkout.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(7)),
                      child: Row(
                        children: [
                          Text(
                            "Start ",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .merge(TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Icon(
                            Icons.play_circle_outline,
                            color: Theme.of(context).accentColor,
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
            Consumer<MembershipProvider>(
              builder: (ctx, memberShipData, _) {
                if (memberShipData.isLoadingMemberShip) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      TodayWorkoutShimmer(),
                      TodayWorkoutShimmer(),
                      TodayWorkoutShimmer(),
                      TodayWorkoutShimmer(),
                    ],
                  );
                }
                return ListView.builder(
                  physics: PageScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: memberShipData.todaysworkouts.length,
                  itemBuilder: (ctx, index) {
                    return TodayWorkoutItem(
                      dailyWorkout: memberShipData.todaysworkouts[index],
                    );
                  },
                );
              },
            ),
            // ListView(
            //   physics: PageScrollPhysics(),
            //   shrinkWrap: true,
            //   children: [
            //     TodayWorkoutItem(),
            //     TodayWorkoutItem(),
            //     TodayWorkoutItem(),
            //   ],
            // )
          ],
        ),
      ),
    ));
  }
}

class TodayWorkoutItem extends StatelessWidget {
  const TodayWorkoutItem({Key? key, required this.dailyWorkout})
      : super(key: key);

  final WorkoutDailyExerciseModel dailyWorkout;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: basicShadow,
                color: Theme.of(context).accentColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.network(
                    Kaimly.server.getFileUrl(
                      fileId: dailyWorkout.exercise.image,
                    ),
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dailyWorkout.exercise.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(TextStyle(fontWeight: FontWeight.w700)),
                      ),
                      Row(
                        children: [
                          timings(context, "${dailyWorkout.time} sec"),
                          timings(context, "${dailyWorkout.count} times"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
        dailyWorkout.isdone
            ? Positioned(
                right: 11,
                bottom: 29,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: successColor,
                        width: 2,
                      )),
                  child: Icon(
                    Icons.check,
                    color: successColor,
                    size: 16,
                  ),
                ))
            : Positioned(
                right: 11,
                bottom: 29,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: dangerColor,
                          width: 2,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Icon(Icons.no_encryption_sharp,
                          size: 16, color: dangerColor),
                    )))
      ],
    );
  }

  Container timings(BuildContext context, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 5, top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        label,
        style: Theme.of(context)
            .accentTextTheme
            .bodyText1!
            .merge(TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class TodayWorkoutShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: basicShadow,
            color: Theme.of(context).accentColor),
        child: Shimmer.fromColors(
          baseColor: shimmerLine,
          highlightColor: Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  width: 60,
                  // color: Colors.cyan,
                  child: shimmerLines(context, bottomMargin: 0)),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    shimmerLines(context, isFull: true, height: 10),
                    shimmerLines(context,
                        width: 80, height: 10, bottomMargin: 0)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 10),
                child: shimmerLines(context, width: 45, bottomMargin: 0),
              )
            ],
          ),
        ));
  }
}


//  Row(
//                             children: [
//                               Text(
//                                 _isStart
//                                     ? "Start "
//                                     : _isPause
//                                         ? "Pause "
//                                         : "Resume ",
//                                 overflow: TextOverflow.ellipsis,
//                                 style: Theme.of(context)
//                                     .accentTextTheme
//                                     .bodyText1!
//                                     .merge(
//                                         TextStyle(fontWeight: FontWeight.bold)),
//                               ),
//                               Icon(
//                                 _isStart
//                                     ? Icons.play_circle_outline
//                                     : _isPause
//                                         ? Icons.pause_circle_outline
//                                         : Icons.play_circle_outline,
//                                 color: Theme.of(context).accentColor,
//                               )
//                             ],
//                           ),