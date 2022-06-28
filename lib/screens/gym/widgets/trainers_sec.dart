import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/Kaimly/modal/user_model.dart';
import 'package:gym_user/core/themes/theme.dart';

import 'package:gym_user/widgets/shimmers/trainersShimmer.dart';

class TrainersSec extends StatefulWidget {
  @override
  _TrainersSecState createState() => _TrainersSecState();
}

class _TrainersSecState extends State<TrainersSec> {
  bool isLoadingTrainers = false;
  List<UserModel> trainers = [];

  loadTrainers() async {
    try {
      setState(() {
        isLoadingTrainers = true;
      });
      final _trainers = await Kaimly.server.users(
          filter: "filter[role][_eq]=979d4be6-8f3f-482e-9ed1-3f2a6bb3e518");
      setState(() {
        trainers = _trainers;
        isLoadingTrainers = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    loadTrainers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingTrainers)
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          TrainerShimmer(),
          TrainerShimmer(),
          TrainerShimmer(),
        ],
      );
    return ListView.builder(
      itemCount: trainers.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return TrainersItem(trainer: trainers[index]);
      },
    );
  }
}

class TrainersItem extends StatelessWidget {
  TrainersItem({required this.trainer});
  final UserModel trainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: basicShadow,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Image.network(
                Kaimly.server.getFileUrl(
                  fileId: trainer.avatar,
                  thumnail: true,
                  height: 100,
                  width: 130,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${trainer.first_name} ${trainer.last_name}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .merge(TextStyle(fontSize: 15)),
                ),
                Text(
                  trainer.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .merge(TextStyle(fontSize: 12)),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Row(
                //   children: [
                //     Image.asset(
                //       "assets/images/insta.png",
                //       scale: 1.3,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Image.asset(
                //       "assets/images/whatsapp.png",
                //       scale: 1.3,
                //     )
                //   ],
                // )
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
