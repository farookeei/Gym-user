import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,

            // childAspectRatio: 3 / 3,
            mainAxisExtent: 140,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
          ),
          itemCount: 6,
          itemBuilder: (ctx, i) {
            return Container(
              // width: double.infinity,
              // height: 80,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: basicShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/sample.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
