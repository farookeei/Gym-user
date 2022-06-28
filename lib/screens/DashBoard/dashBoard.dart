import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_user/core/providers/routeProvider.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/allScreens.dart';
import 'package:gym_user/screens/gym/gym.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    Provider.of<RouteProvider>(context, listen: false).controller = controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: TabBarView(
        physics: ClampingScrollPhysics(),
        // dragStartBehavior: DragStartBehavior.down,
        controller: controller,
        children: [
          HomeScreen(),
          Workout(),
          Gym(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
              color: textformfieldShadowcolor,
              offset: Offset(0, 4),
              blurRadius: 25,
            )
          ],
        ),
        child: TabBar(
          controller: controller,
          // unselectedLabelColor: Colors.black,
          // labelColor: Theme.of(context).primaryColor,
          labelStyle: Theme.of(context).primaryTextTheme.bodyText1!.merge(
                TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
          unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
          indicatorPadding: EdgeInsets.only(bottom: 0),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            // color: Theme.of(context).primaryColor,

            image: DecorationImage(
              alignment: Alignment.topCenter,
              // colorFilter: ColorFilter.mode(
              //     Theme.of(context).primaryColor, BlendMode.srcATop),
              image: AssetImage('assets/images/navigationSelected.png'),
              scale: 1.5,
            ),
          ),
          labelPadding: EdgeInsets.only(top: 16, bottom: 15),
          tabs: [
            TabBarImageIcon(
              imageurl: "assets/images/Bold/Home.png",
              text: "Home",
            ),
            TabBarImageIcon(
              imageurl: "assets/images/Bold/Gym weight-2.png",
              text: "Workout",
            ),
            TabBarImageIcon(
              imageurl: "assets/images/Bold/Location.png",
              text: "Gym",
            ),
            TabBarImageIcon(
              imageurl: "assets/images/Bold/Profile.png",
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarImageIcon extends StatelessWidget {
  const TabBarImageIcon({
    required this.imageurl,
    required this.text,
    this.color = const Color(0x00000000),
  });

  final String imageurl;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      constraints: BoxConstraints(maxHeight: 45),
      child: Column(
        children: [
          Image.asset(
            imageurl,
            // color: Theme.of(context).primaryColor,
            height: 24,
          ),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
