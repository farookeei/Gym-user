import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/WorkoutDailyExerciseModel.dart';
import 'package:gym_user/core/providers/membershipProvider.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/SingleWorkout/widgets/countAndDuration.dart';
import 'package:gym_user/screens/SingleWorkout/widgets/stopWatch.dart';
import 'package:gym_user/screens/SingleWorkout/widgets/workoutmainDetails.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:gym_user/widgets/customAppbar.dart';
import 'package:gym_user/widgets/customBtn.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'widgets/customBtns.dart';

class SingleWorkout extends StatefulWidget {
  static const routeName = "single-workout";

  @override
  _SingleWorkoutState createState() => _SingleWorkoutState();
}

class _SingleWorkoutState extends State<SingleWorkout> {
  bool isStart = true;
  bool isStartTimer = false;
  bool isPause = false;
  bool isRestScreen = false;
  bool isFinishScreen = false;
  bool showFinishbutton = false;
  int _restTime = 15;

  StopWatchController _stopWatchController = StopWatchController();

  @override
  void dispose() {
    _stopWatchController.cancel();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  Timer? _timer;

  void initTimer(int duration) {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      timeRunner,
    );
  }

  void restartTimer(int duration) {
    cancelTimer();
    initTimer(duration);
    setState(() {
      showFinishbutton = false;
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = null;
  }

  void timeRunner(Timer timer) {
    if (_restTime == 0) {
      isRestScreen = false;
      setState(() {
        isRestScreen = false;
        isStart = true;
        isPause = false;
      });
      timer.cancel();
      cancelTimer();
      restartCountdown();
      print("timer restart");
    } else {
      setState(() {
        _restTime--;
      });
    }
  }

  void restartCountdown() {
    print("timer restart fn");
    setState(() {
      isStartTimer = true;
      // _initduration = initduration;
    });
  }

  @override
  void initState() {
    super.initState();
    //:TODO make sure this logic is correct
    if (Provider.of<MembershipProvider>(context, listen: false)
            .currentDailyExercisePosition ==
        Provider.of<MembershipProvider>(context, listen: false)
            .todaysworkouts
            .length) {
      setState(() {
        isFinishScreen = true;
      });
    }
  }

  int _curentDuration = 0;
  int initDur = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: customAppbar(context, label: "Today's Workouts"),
          body: Consumer<MembershipProvider>(
            builder: (ctx, membershipData, _) {
              WorkoutDailyExerciseModel _currentWorkout = membershipData
                  .todaysworkouts[membershipData.currentDailyExercisePosition <
                      membershipData.todaysworkouts.length
                  ? membershipData.currentDailyExercisePosition
                  : 0];
              bool _islastExercise = membershipData.todaysworkouts.length ==
                  membershipData.currentDailyExercisePosition + 1;

              int _curentDuration = _currentWorkout.time;
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    isRestScreen
                        ? restScreen(context, _currentWorkout.time)
                        : isFinishScreen
                            ? Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Lottie.asset(
                                      'assets/animations/success2.json',
                                      repeat: false,
                                      height: 160),
                                ),
                              )
                            : Expanded(
                                child: WorkoutMainDetails(
                                  image: Kaimly.server.getFileUrl(
                                      fileId: _currentWorkout.exercise.image),
                                  title: _currentWorkout.exercise.name,
                                ),
                              ),
                    Container(
                      height: 340,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment(-1, -1.8),
                                  end: Alignment(1, 1.8),
                                  colors: [timerGGradient1, primaryColor]),
                            ),
                            padding: const EdgeInsets.only(top: 20),
                            child: isFinishScreen
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          "Today’s workout is done have a nice day",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .accentTextTheme
                                              .headline6,
                                        ),
                                      ),
                                      CustomBtn(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          label: "Return To Home",
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: Theme.of(context).primaryColor)
                                    ],
                                  )
                                : timerDisplayWidget(context, membershipData,
                                    _currentWorkout, _islastExercise),
                          ),
                          !isRestScreen && !isFinishScreen
                              ? CountsAndDuration(
                                  count: _currentWorkout.count,
                                  duration: _currentWorkout.time,
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  Column timerDisplayWidget(
      BuildContext context,
      MembershipProvider membershipData,
      WorkoutDailyExerciseModel _currentWorkout,
      bool _islastExercise) {
    if (_curentDuration == 0) {
      _curentDuration = _currentWorkout.time;
    }
    return Column(
      children: [
        Container(
          height: 90,
          // child: Text(
          //   "Take Rest",
          //   style:
          //       Theme.of(context).accentTextTheme.headline6!,
          // ),
        ),
        Container(
          height: 100,
          // height: 110,
          child: Container(
            // margin: EdgeInsets.only(top: 20),
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SkipWorkoutBtn(
                  onTap: () {
                    membershipData.finishAworkoutDailyExercise(_currentWorkout);
                    if (!_islastExercise) {
                      // setState(() {
                      //   isRestScreen = true;
                      //   restartTimer(_currentWorkout.time);
                      // });

                      membershipData
                          .finishAworkoutDailyExercise(_currentWorkout);
                    }
                    if (_islastExercise) {
                      {
                        membershipData
                            .finishAworkoutDailyExercise(_currentWorkout);
                        setState(() {
                          isRestScreen = false;
                          isFinishScreen = true;
                        });
                      }
                    }
                  },
                ),
                InkWell(
                    onTap: () {
                      if (_stopWatchController.ispaused) {
                        _stopWatchController.resume();
                        return;
                      }

                      if (isStartTimer) {
                        _stopWatchController.pause();
                        return;
                      }

                      setState(() {
                        isStartTimer = true;
                      });
                      _stopWatchController.start(
                          duration: _curentDuration, initDuration: 0);
                      _stopWatchController.onFinish = (dur) {
                        setState(() {
                          _curentDuration = _curentDuration + dur;
                          initDur = dur;
                          if (!showFinishbutton) {
                            showFinishbutton = true;
                          }
                        });
                      };
                    },
                    child: StopWatch(
                      controller: _stopWatchController,
                      duration: _curentDuration,
                      initduration: initDur,
                      isStart: isStartTimer,
                      // isPaused: isPause,
                    )),
                showFinishbutton
                    ? CompleteWorkoutBtn(
                        onTap: () {
                          print(_currentWorkout.toString());
                          membershipData
                              .finishAworkoutDailyExercise(_currentWorkout);
                          if (!_islastExercise) {
                            setState(() {
                              isRestScreen = true;
                              isStartTimer = false;
                              restartTimer(_currentWorkout.time);
                              _curentDuration = 0;
                              initDur = 0;
                              _restTime = 15;
                            });
                          }

                          if (_islastExercise) {
                            {
                              setState(() {
                                isRestScreen = false;
                                isFinishScreen = true;
                              });
                            }
                          }
                        },
                        isLastExercise: _islastExercise,
                      )
                    : Container(
                        width: 100,
                      )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tap the timer to play/pause ",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .accentTextTheme
                    .bodyText1!
                    .merge(TextStyle(fontWeight: FontWeight.w600, fontSize: 8)),
              ),
              Image.asset(
                "assets/images/pause2.png",
                height: 10,
                width: 10,
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        )
      ],
    );
  }

  Expanded restScreen(BuildContext context, int time) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Cool Down Time",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .merge(TextStyle(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "$_restTime s",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .merge(TextStyle(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBtn(
                width: 80,
                height: 40,
                margin: EdgeInsets.all(0),
                label: "+20s ",
                padding: EdgeInsets.only(right: 5),
                radiusBL: 10,
                radiusTL: 10,
                radiusBR: 10,
                radiusTR: 10,
                onPressed: () {
                  setState(() {
                    if (_restTime == 0) {
                      restartTimer(time);
                    }
                    _restTime = _restTime + 20;
                    print(_restTime.toString());
                  });
                },
                color: changeBtn,
              ),
              const SizedBox(width: 10),
              CustomBtn(
                width: 80,
                height: 40,
                label: "Skip",
                labelColor: Theme.of(context).accentColor,
                padding: EdgeInsets.only(right: 4),
                radiusBL: 10,
                radiusTL: 10,
                radiusBR: 10,
                radiusTR: 10,
                margin: EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    _restTime = 0;
                  });
                },
                color: Theme.of(context).primaryColor,
              )
            ],
          )
        ],
      ),
    ));
  }
}
