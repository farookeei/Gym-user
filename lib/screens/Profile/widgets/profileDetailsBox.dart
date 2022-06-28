import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

class ProfileDetailBox extends StatelessWidget {
  final List<Widget> widgets;

  ProfileDetailBox({required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: basicShadow,
          borderRadius: BorderRadius.circular(10)),
      child: Column(children: widgets),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String imageurl;
  final String label;
  final Function onClick;
  ProfileTile({
    required this.onClick,
    required this.imageurl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                imageurl,
                height: 24,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 6,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyText1!.merge(
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
