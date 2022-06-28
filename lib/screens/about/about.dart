import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/customAppbar.dart';

class About extends StatelessWidget {
  static const routename = 'about';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppbar(context, label: ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 140,
              ),
              Text(
                "Gym Kit",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .merge(TextStyle(fontSize: 15)),
              ),
              Text(
                "Edappally, Kochi \n",
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1!
                    .merge(TextStyle(fontSize: 12)),
              ),
              Text(
                "Gym is also slang for fitness centre, which is often an area for indoor recreation. A gym may be open air as well. A gym is a place with a number of equipments and machines used by the people to do exercises",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .merge(TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 20),
              CustomExpansion(
                leading: "assets/images/refund.png",
                label: "Refund Policy",
                content: "cdscsdcdscdsc",
              ),
              CustomExpansion(
                leading: "assets/images/Lock.png",
                label: "Privacy Policy",
                content: "cdscsdcdscdsc",
              ),
              CustomExpansion(
                leading: "assets/images/Bold/Chart.png",
                label: "Terms and Conditions",
                content: "cdscsdcdscdsc",
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CustomExpansion extends StatelessWidget {
  final String leading;
  final String label;
  final String content;

  CustomExpansion(
      {required this.content, required this.label, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerColor: Theme.of(context).accentColor,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ExpansionTile(
            collapsedBackgroundColor: Theme.of(context).accentColor,
            title: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .merge(TextStyle(fontWeight: FontWeight.w500)),
            ),
            expandedAlignment: Alignment.topLeft,
            // expandedCrossAxisAlignment: CrossAxisAlignment.start,
            backgroundColor: Theme.of(context).accentColor,
            iconColor: primaryColor,
            textColor: primaryColor,
            collapsedIconColor: primaryColor,
            collapsedTextColor: primaryColor,

            maintainState: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22, bottom: 10),
                child: Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(TextStyle(fontSize: 12)),
                ),
              )
            ],
            leading: Image.asset(
              leading,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
