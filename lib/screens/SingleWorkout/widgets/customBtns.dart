//* If it is last exercise finish btn is placed
import 'package:flutter/material.dart';
import 'package:gym_user/core/models/WorkoutDailyExerciseModel.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/customBtn.dart';

class CompleteWorkoutBtn extends StatelessWidget {
  final bool isLastExercise;
  final Function onTap;
  CompleteWorkoutBtn({
    this.isLastExercise = false,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return isLastExercise
        ? CustomBtn(
            label: "Finish",
            onPressed: () {
              onTap();
            },
            color: changeBtn,
            height: 30,
            width: 70,
            padding: const EdgeInsets.only(right: 5),
          )
        : InkWell(
            onTap: () => onTap(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.only(bottom: 1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      color: changeBtn,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "assets/images/tick.png",
                  ),
                ),
                Text(
                  "Complete exercise",
                  style: Theme.of(context)
                      .accentTextTheme
                      .bodyText1!
                      .merge(TextStyle(fontSize: 10)),
                ),
              ],
            ),
          );
  }
}

class SkipWorkoutBtn extends StatelessWidget {
  final Function onTap;
  SkipWorkoutBtn({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              "assets/images/skip.png",
              height: 24,
              width: 24,
              color: Theme.of(context).accentColor,
            ),
          ),
          Text("Skip this workout",
              style: Theme.of(context)
                  .accentTextTheme
                  .bodyText1!
                  .merge(TextStyle(fontSize: 10)))
        ],
      ),
    );
  }
}
