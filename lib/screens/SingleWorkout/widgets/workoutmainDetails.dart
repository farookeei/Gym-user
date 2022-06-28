import 'package:flutter/material.dart';

class WorkoutMainDetails extends StatelessWidget {
  final String image;
  final String title;

  WorkoutMainDetails({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Clock is ticking.Complete todays workout workout  todays workout Comp todays workout",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText1!
                        .merge(TextStyle(fontSize: 13)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Do the above exercise as shown below",
            style: Theme.of(context)
                .textTheme
                .caption!
                .merge(TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
