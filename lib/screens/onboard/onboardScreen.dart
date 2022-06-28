import 'package:flutter/material.dart';
import 'package:gym_user/screens/LoginScreen/LoginScreen.dart';
import 'package:gym_user/widgets/customBtn.dart';

class OnboardScreen extends StatefulWidget {
  static const routeName = "/onboard-screen";
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

int _initialPage = 0;
final PageController _pageController =
    PageController(initialPage: _initialPage);

class _OnboardScreenState extends State<OnboardScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int activeTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    _tabController!.addListener(() {
      setState(() => activeTabIndex = _tabController!.index);
    });

    super.initState();
  }

  void nextBtn() {
    int _index = _tabController!.index;

    if (_index == 2) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      return null;
    }

    setState(() => _tabController!.index = _tabController!.index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.linearToSrgbGamma(),
          image: AssetImage(
            "assets/images/onboard2.jpg",
          ),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.7,
                child: DefaultTabController(
                  length: 3,
                  child: TabBarView(controller: _tabController, children: [
                    OnBoardScreens(
                      title: 'Building Better\n    Workplaces ',
                      subTitle:
                          'Create a unique emotional story\nthat describes better than words',
                    ),
                    OnBoardScreens(
                      title: 'Building Better\n    Workplaces ',
                      subTitle:
                          'Create a unique emotional story\nthat describes better than words',
                    ),
                    OnBoardScreens(
                      title: 'Building Better\n   Workplaces ',
                      subTitle:
                          'Create a unique emotional story\nthat describes better than words',
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Indicator(activeIndex: activeTabIndex),
                    CustomBtn(
                      radiusBL: 15,
                      radiusTL: 15,
                      label:
                          _tabController!.index != 2 ? "Next" : "Get Started",
                      radiusTR: 15,
                      radiusBR: 15,
                      onPressed: nextBtn,
                      color: Theme.of(context).primaryColor,
                      width: 300,
                      height: 55,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int activeIndex;
  Indicator({required this.activeIndex});
  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).accentColor;
    final deactiveColor = Theme.of(context).accentColor.withOpacity(0.2);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: activeIndex == 0 ? activeColor : deactiveColor,
          ),
          const SizedBox(width: 7),
          CircleAvatar(
            radius: 4,
            backgroundColor: activeIndex == 1 ? activeColor : deactiveColor,
          ),
          const SizedBox(width: 7),
          CircleAvatar(
            radius: 4,
            backgroundColor: activeIndex == 2 ? activeColor : deactiveColor,
          ),
        ],
      ),
    );
  }
}

class OnBoardScreens extends StatelessWidget {
  final String title;
  final String subTitle;

  OnBoardScreens({
    required this.subTitle,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 200),
        titles(screenWidth, context),
        const SizedBox(height: 10),
        subTitles(screenWidth, context),
      ],
    );
  }

  Container subTitles(double screenWidth, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.8,
      child: Text(
        subTitle,
        style: Theme.of(context)
            .accentTextTheme
            .caption!
            .merge(TextStyle(letterSpacing: 1.1)),
      ),
    );
  }

  Container titles(double screenWidth, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.8,
      child: Text(
        title,
        style: Theme.of(context).accentTextTheme.headline5!.merge(TextStyle(
            fontWeight: FontWeight.w700, color: Theme.of(context).accentColor)),
      ),
    );
  }
}
