import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/providers/authProvider.dart';
import 'package:gym_user/core/themes/gymData.dart';
import 'package:gym_user/screens/LoginScreen/LoginScreen.dart';
import 'package:gym_user/screens/about/about.dart';
import 'package:gym_user/screens/transcations/transaction.dart';
import 'package:gym_user/widgets/memberProgress.dart';
import 'package:provider/provider.dart';
import 'widgets/profileDetailsBox.dart';
import '../../widgets/profileHeader.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ProfileHeader(),
            // EditButton(),
            const SizedBox(height: 20),
            // MembershipProgress(),
            ProfileDetailBox(
              widgets: [
                ProfileTile(
                  imageurl: "assets/images/Bold/Location.png",
                  label: gymName,
                  onClick: () {},
                ),
                ProfileTile(
                  imageurl: "assets/images/Bold/Add User.png",
                  label: gymOwner,
                  onClick: () {},
                ),
                ProfileTile(
                  imageurl: "assets/images/Bold/Call.png",
                  label: gymPhone,
                  onClick: () {},
                ),
                ProfileTile(
                  imageurl: "assets/images/Bold/Message.png",
                  label: gymEmail,
                  onClick: () {},
                ),
              ],
            ),
            ProfileDetailBox(widgets: [
              ProfileTile(
                imageurl: "assets/images/Bold/Wallet.png",
                label: "Transaction & Invoice ",
                onClick: () {
                  Navigator.pushNamed(context, Transaction.routeName);
                },
              ),
              ProfileTile(
                imageurl: "assets/images/Bold/Download.png",
                label: "Download Invoice",
                onClick: () {},
              ),
              ProfileTile(
                imageurl: "assets/images/Bold/Chart.png",
                label: "Attendance",
                onClick: () {},
              ),
              ProfileTile(
                imageurl: "assets/images/Bold/Logout.png",
                label: "About",
                onClick: () {
                  Navigator.pushNamed(context, About.routename);
                },
              ),
            ]),
            ProfileDetailBox(
              widgets: [
                ProfileTile(
                  imageurl: "assets/images/Bold/Logout.png",
                  label: "Logout",
                  onClick: () {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Powered by KAIMLY",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .merge(TextStyle(fontWeight: FontWeight.normal)),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Edit",
                  style: Theme.of(context)
                      .accentTextTheme
                      .bodyText1!
                      .merge(TextStyle(fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  width: 5,
                ),
                // Image.asset(
                //   "assets/images/Bold/Edit.png",
                //   height: 24,
                // )
                Image(
                  image: AssetImage("assets/images/Bold/Edit.png"),
                  color: Colors.white,
                  height: 15,
                )
              ],
            )),
      ),
    );
  }
}
