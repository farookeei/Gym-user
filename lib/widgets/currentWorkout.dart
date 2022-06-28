import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/WorkoutModel.dart';
import 'package:gym_user/core/providers/membershipProvider.dart';
import 'package:gym_user/core/providers/routeProvider.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CurrentWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Consumer<MembershipProvider>(
        builder: (ctx, membershipData, _) {
          if (membershipData.isLoadingMemberShip) {
            return CurrentWorkouShimmer();
          }
          return currentWorkoutData(
              context, membershipData.membership!.currentWorkout);
        },
      ),
    );
  }

  Column currentWorkoutData(BuildContext context, WorkoutModel workout) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Current course",
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText1!
                  .merge(TextStyle(fontSize: 14)),
            ),
            InkWell(
              onTap: () {
                Provider.of<RouteProvider>(context, listen: false)
                    .setGymScreen(GymScreens.course);
                Provider.of<RouteProvider>(context, listen: false)
                    .controller
                    .animateTo(2);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                decoration: BoxDecoration(
                  color: changeBtn,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Text(
                      "Change  ",
                      style: Theme.of(context).accentTextTheme.bodyText1!.merge(
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                    Image.asset(
                      "assets/images/Bold/Arrow - Right Circle.png",
                      color: Theme.of(context).accentColor,
                      height: 24,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        //?s
        Expanded(
          child: Container(
            // margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              boxShadow: basicShadow,
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Image.network(
                      Kaimly.server.getFileUrl(fileId: workout.image),
                      // scale: 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        workout.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .merge(TextStyle(fontSize: 16)),
                      ),
                      Text(
                        workout.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .merge(TextStyle(fontSize: 12)),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CurrentWorkouShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: shimmerLine,
          highlightColor: Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerLines(context,
                  width: 80, height: 25, bottomMargin: 0, radius: 0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                child: shimmerLines(context,
                    width: 60, height: 25, bottomMargin: 0, radius: 30),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 90,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Shimmer.fromColors(
            baseColor: shimmerLine,
            highlightColor: Theme.of(context).accentColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shimmerLines(context, width: 100, height: 90, bottomMargin: 0),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: shimmerLines(
                          context,
                        ),
                      ),
                      shimmerLines(
                        context,
                        bottomMargin: 0,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
        )
      ],
    );
  }
}
