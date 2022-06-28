import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/allScreens.dart';

class ProfileHeader extends StatelessWidget {
  final bool isScan;

  ProfileHeader({this.isScan = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Kaimly.server.getMe().first_name} ${Kaimly.server.getMe().last_name}',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .merge(TextStyle(fontWeight: FontWeight.w700)),
              ),
              Text(
                '${Kaimly.server.getMe().email}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        isScan
            ? InkWell(
                splashColor: changeBtn,
                onTap: () {
                  Navigator.pushNamed(context, QrScan.routeName);
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    "assets/images/Bold/Scan.png",
                    height: 24,
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }
}
