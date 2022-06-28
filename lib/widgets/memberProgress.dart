import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/MembershipModel.dart';
import 'package:gym_user/core/providers/membershipProvider.dart';
import 'package:gym_user/core/providers/routeProvider.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/widgets/shimmeer_lines.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MembershipProgress extends StatefulWidget {
  @override
  _MembershipProgressState createState() => _MembershipProgressState();
}

class _MembershipProgressState extends State<MembershipProgress> {
  // bool _isLoadingMemberShip = true;

  // late MembershihpModel membership;

  // loadMemberShip() async {
  //   try {
  //     setState(() {
  //       _isLoadingMemberShip = true;
  //     });
  //     final _membership =
  //         await Kaimly.server.items(collection: 'user_plan_validity');
  //     print(_membership['data'][0]);
  //     setState(() {
  //       membership = MembershihpModel.convert(_membership['data'][0]);
  //       _isLoadingMemberShip = false;
  //     });
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // @override
  // void initState() {
  //   loadMemberShip();
  //   super.initState();
  // }
  // loadmembership() async {
  //   await Provider.of<MembershipProvider>(context, listen: false)
  //       .loadMemberShip();
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<MembershipProvider>(context, listen: false).loadMemberShip();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 25,
      ),
      decoration: BoxDecoration(
          boxShadow: basicShadow,
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10)),
      child: Consumer<MembershipProvider>(
        builder: (context, membershipData, _) {
          return membershipData.isLoadingMemberShip
              ? MemberShipShimmer()
              : memebrshipdata(context, membershipData.membership);
        },
      ),
    );
  }

  Row memebrshipdata(BuildContext context, MembershipModel? membership) {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${membership!.validTillDate.difference(DateTime.now()).inDays} Days",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .merge(TextStyle(fontWeight: FontWeight.w700)),
                ),
                Text(
                  "left in membership",
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                ),
                TextButton(
                  child: Text(
                    "Renew",
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .merge(TextStyle(color: textformfieldfillcolor)),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(successColor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 10),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.4),
                      ))),
                  onPressed: () {
                    Provider.of<RouteProvider>(context, listen: false)
                        .setGymScreen(GymScreens.pricing);
                    Provider.of<RouteProvider>(context, listen: false)
                        .controller
                        .animateTo(2);
                  },
                )
              ],
            )),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          // flex: 2,
          child: Container(
            padding: EdgeInsets.only(right: 20),
            child: CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 8.0,
              animation: true, restartAnimation: true, animationDuration: 600,

              percent:
                  membership.validTillDate.difference(DateTime.now()).inDays /
                      membership.days_count,
              center: Text(
                "${membership.validTillDate.difference(DateTime.now()).inDays} Days",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
              ),
              animateFromLastPercent: true,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Theme.of(context).primaryColor,
              // progressColor: Colors.greenAccent,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
}

class MemberShipShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerLine,
      highlightColor: Theme.of(context).accentColor,
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerLines(context, width: 120),
                  shimmerLines(context, isFull: true),
                  shimmerLines(context, width: 90)
                ],
              )),
          const SizedBox(
            width: 7,
          ),
          Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: 50,
                child: SizedBox(),
              )),
        ],
      ),
    );
  }
}
