import 'package:flutter/material.dart';
import 'package:gym_user/core/providers/routeProvider.dart';
import 'package:gym_user/core/themes/gymData.dart';

import 'package:gym_user/widgets/customChips.dart';
import 'package:provider/provider.dart';

import 'widgets/basic_workouts.dart';
import 'widgets/equipments.dart';
import 'widgets/gallery.dart';
import 'widgets/pricing.dart';
import 'widgets/trainers_sec.dart';

class Gym extends StatefulWidget {
  static const routeName = "/gym";
  @override
  _GymState createState() => _GymState();
}

class _GymState extends State<Gym> {
  // String contentHeader = GymScreens.course;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Consumer<RouteProvider>(
          builder: (ctx, routes, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GymHeader(),
                ChipsOptions(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  defaultPadding: const EdgeInsets.symmetric(horizontal: 0),
                  values: [
                    "Course",
                    "Pricing",
                    "Trainers",
                    // "Gallery",
                    "Equipments",
                  ],
                  // defaultSelected: 0,
                  defaultSelected:
                      GymScreens.getDefaultSelectedIn(routes.gymScreen),
                  onTap: (e) {
                    // setState(() {
                    //   contentHeader = e;
                    // });
                    Provider.of<RouteProvider>(context, listen: false)
                        .setGymScreen(e);
                  },
                ),
                Text(
                  routes.gymScreen == "Course"
                      ? "Course"
                      : routes.gymScreen == "Pricing"
                          ? "Pricing"
                          : routes.gymScreen == "Trainers"
                              ? "Trainers"
                              : routes.gymScreen == "Gallery"
                                  ? "Gallery"
                                  : "Equipments",
                  style: Theme.of(context).textTheme.headline6!.merge(
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    routes.gymScreen == "Course"
                        ? BasicWorkouts()
                        : routes.gymScreen == "Trainers"
                            ? TrainersSec()
                            : routes.gymScreen == "Pricing"
                                ? Pricing()
                                : routes.gymScreen == "Equipments"
                                    ? Equipments()
                                    : Gallery()
                  ],
                ))
              ],
            );
          },
        ),
      ),
    ));
  }
}

class GymHeader extends StatelessWidget {
  const GymHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/logo.png",
          height: 90,
          width: 90,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gymName,
                style: Theme.of(context).textTheme.headline6!.merge(TextStyle(
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Text(
                gymLocation,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
