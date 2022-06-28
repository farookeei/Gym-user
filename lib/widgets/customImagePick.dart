import 'package:flutter/material.dart';
import 'package:gym_user/core/themes/theme.dart';

class CustomImagePick extends StatelessWidget {
  final String fileName;
  final Function onTap;

  CustomImagePick({required this.fileName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 13, horizontal: 0),
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 26),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: textformfieldfillcolor,
          boxShadow: basicShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              child: Text(
                fileName.isEmpty ? "Upload profile picture" : fileName,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
            Image.asset(
              "assets/images/Bold/Download.png",
              height: 24,
              width: 24,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
