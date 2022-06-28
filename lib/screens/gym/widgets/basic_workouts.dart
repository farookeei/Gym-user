import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/WorkoutModel.dart';
import 'package:gym_user/core/providers/membershipProvider.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/customBtn.dart';

import 'package:gym_user/widgets/customOutlineBtn.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:gym_user/widgets/shimmers/basicWorkout_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BasicWorkouts extends StatefulWidget {
  const BasicWorkouts({
    Key? key,
  }) : super(key: key);

  @override
  _BasicWorkoutsState createState() => _BasicWorkoutsState();
}

class _BasicWorkoutsState extends State<BasicWorkouts> {
  bool isLoadingWorkouts = false;
  List<WorkoutModel> workouts = [];
  loadWorkouts() async {
    try {
      setState(() {
        isLoadingWorkouts = true;
      });
      final _workouts = await Kaimly.server
          .items(collection: 'workout', fields: 'fields=*.*.*');
      // print(_workouts);
      setState(() {
        workouts = WorkoutModel.convertlist(_workouts);
        isLoadingWorkouts = false;
      });
    } catch (e) {
      setState(() {
        isLoadingWorkouts = false;
        print(e);
      });
    }
  }

  @override
  void initState() {
    loadWorkouts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingWorkouts)
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          WorkoutItemShimmer(),
          WorkoutItemShimmer(),
          WorkoutItemShimmer(),
        ],
      );
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: workouts.length,
      itemBuilder: (ctx, index) {
        return WorkoutItem(workout: workouts[index]);
      },
    );
  }
}

class WorkoutItem extends StatefulWidget {
  const WorkoutItem({
    required this.workout,
  });

  final WorkoutModel workout;

  @override
  _WorkoutItemState createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  bool isloadingChangeWrokout = false;

  changeWorkout() async {
    try {
      setState(() {
        isloadingChangeWrokout = true;
      });
      await Kaimly.server.updateitem(
          collection: 'user_plan_validity',
          id: Provider.of<MembershipProvider>(context, listen: false)
              .membership!
              .id,
          body: {
            "current_workout": widget.workout.id,
            "last_done_daily_workout": null
          });
      await Provider.of<MembershipProvider>(context, listen: false)
          .loadMemberShip();
      setState(() {
        isloadingChangeWrokout = false;
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: basicShadow,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              // color: Colors.green,
              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.workout.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline6!.merge(
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                  Text(
                    widget.workout.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1!.merge(
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
                  ),
                  //     : SizedBox.shrink(),
                  Consumer<MembershipProvider>(
                    builder: (ctx, meberShipData, _) {
                      if (isloadingChangeWrokout ||
                          meberShipData.isLoadingMemberShip) {
                        return Shimmer.fromColors(
                          baseColor: shimmerLine,
                          highlightColor: Theme.of(context).accentColor,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: shimmerLines(context,
                                isFull: false,
                                radius: 9,
                                width: 75,
                                height: 30,
                                bottomMargin: 0),
                          ),
                        );
                      }
                      if (meberShipData.membership!.currentWorkout.id ==
                          widget.workout.id) {
                        return CustomBtn2(
                            contColor: Theme.of(context).primaryColor,
                            label: "Selected",
                            onTap: () {},
                            textColor: Theme.of(context).accentColor);
                      }
                      return Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                blurRadius: 15.76,
                                color: courseItemShadow,
                                spreadRadius: 0,
                                offset: Offset(0, 2.52))
                          ]),
                          child: CustomBtn2(
                              contColor: Theme.of(context).accentColor,
                              label: "Select  ",
                              onTap: () {
                                changeWorkout();
                              },
                              textColor: Theme.of(context).primaryColor));
                    },
                  )
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: Image.network(
                    Kaimly.server.getFileUrl(
                      thumnail: false,
                      fileId: widget.workout.image,
                    ),
                    fit: BoxFit.cover,
                    width: 120,
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 120,
                decoration: BoxDecoration(
                  // color: courseItemShadow,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).accentColor.withOpacity(1),
                        Theme.of(context).accentColor.withOpacity(0)
                      ]),
                ),
                child: SizedBox(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomBtn2 extends StatelessWidget {
  final String label;
  final Color contColor;
  final Color textColor;
  final Function onTap;

  CustomBtn2(
      {required this.contColor,
      required this.label,
      required this.onTap,
      required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: contColor),
      child: TextButton(
        // style: ButtonStyle(
        //   padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        // ),
        onPressed: () => onTap(),
        child: Text(label,
            style: Theme.of(context).accentTextTheme.bodyText1!.merge(TextStyle(
                fontWeight: FontWeight.w600, color: textColor, fontSize: 12))),
      ),
    );
  }
}
