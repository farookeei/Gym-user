import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/Thought.dart';
import 'package:gym_user/widgets/currentWorkout.dart';
import 'package:gym_user/widgets/customGraph.dart';
import 'package:gym_user/widgets/memberProgress.dart';
import 'package:gym_user/widgets/profileHeader.dart';
import 'widgets/thoughtItem.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ThoughtModel> thoughts = [];
  bool isLoadingthought = false;
  final random = new Random();

  loadThought() async {
    try {
      setState(() {
        isLoadingthought = true;
      });
      final _thoughts = await Kaimly.server.items(collection: 'thought_list');
      // print(thoughts);
      setState(() {
        thoughts = ThoughtModel.convertlist(_thoughts);
        isLoadingthought = false;
      });
    } catch (e) {
      // loadThought();
      throw e;
    }
  }

  @override
  void initState() {
    loadThought();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 30),
              ProfileHeader(
                // me: _user,
                isScan: true,
              ),
              ThoughtItem(
                isLoading: isLoadingthought,
                thought: !isLoadingthought
                    ? thoughts[random.nextInt(thoughts.length)].thought
                    : '',
                bywho: !isLoadingthought
                    ? thoughts[random.nextInt(thoughts.length)].by_who
                    : '',
              ),
              MembershipProgress(),
              // ChartShimmer(),
              // CustomBarGraph(
              //   isBottomWidget: true,
              //   values: [2, 4, 6, 8, 9, 10, 11],
              //   marginBottom: 0,
              // ),
              CurrentWorkout()
            ],
          ),
        ),
      ),
    );
  }
}
