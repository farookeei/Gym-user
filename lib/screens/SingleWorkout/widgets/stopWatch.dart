import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StopWatchController extends ChangeNotifier {
  VoidCallback stop = () {};
  VoidCallback pause = () {};
  VoidCallback resume = () {};
  void Function({int duration, int initDuration}) start =
      ({duration: 0, initDuration: 0}) {};

  bool ispaused = false;

  void restart = () {};

  void Function(int duration) onFinish = (duration) {};

  VoidCallback cancel = () {};

  void dispose() {
    start = ({duration: 0, initDuration: 0}) {};
    stop = () {};
  }
}

class StopWatch extends StatefulWidget {
  StopWatch({
    Key? key,
    required this.controller,
    this.duration = 0,
    this.initduration = 0,
    this.isStart = false,
    this.isPaused = false,
  }) : super(key: key);

  final StopWatchController controller;
  bool isStart;
  bool isPaused;
  int duration;
  int initduration;

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Timer? _timer;

  int getCurrentTime() {
    return widget.initduration;
  }

  void initTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      timeRunner,
    );
  }

  void restartTimer({int? duration, int? initDuration}) {
    if (duration != null) {
      setState(() {
        widget.duration = duration;
      });
    }
    if (initDuration != null) {
      setState(() {
        widget.initduration = initDuration;
      });
    }
    // cancelTimer();
    initTimer();
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void timeRunner(Timer timer) {
    print("timer running");
    if (!mounted) {
      cancelTimer();
      return;
    }
    if (!widget.isStart || widget.isPaused) {
      return;
    }
    if (widget.initduration < widget.duration) {
      setState(() {
        widget.initduration++;
      });
    } else {
      widget.controller.onFinish(widget.initduration);
      // cancelTimer();
    }
  }

  void pause() {
    setState(() {
      widget.isPaused = true;
    });
    widget.controller.ispaused = widget.isPaused;
  }

  void resume() {
    setState(() {
      widget.isPaused = false;
    });
    widget.controller.ispaused = widget.isPaused;
  }

  @override
  void initState() {
    StopWatchController _controller = widget.controller;
    if (_controller != null) {
      _controller.start = restartTimer;
      _controller.stop = cancelTimer;
      _controller.cancel = cancelTimer;
      _controller.pause = pause;
      _controller.resume = resume;
      _controller.ispaused = widget.isPaused;
    }
    super.initState();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = widget.initduration ~/ 60;
    int seconds = widget.initduration - minutes * 60;
    return Container(
      child: CircularPercentIndicator(
        percent: ((widget.initduration / widget.duration) * 100) / 100,
        radius: 100,
        progressColor: Theme.of(context).primaryColor,
        backgroundColor: bodyText2,
        center: Text(
          !widget.isStart
              ? "Start"
              : "${minutes ~/ 10 == 0 ? '0$minutes' : minutes} : ${seconds ~/ 10 == 0 ? '0$seconds' : seconds}",
          style: Theme.of(context)
              .accentTextTheme
              .headline6!
              .merge(TextStyle(fontSize: 14)),
        ),
        // animation: true,
      ),
    );
  }
}
