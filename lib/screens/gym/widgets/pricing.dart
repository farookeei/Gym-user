import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/PricingModel.dart';

import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/allScreens.dart';

import 'package:gym_user/widgets/shimmers/pricingShimmer.dart';

class Pricing extends StatefulWidget {
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  bool isLoadingpricing = false;
  List<PricingModel> pricing = [];

  loadpricing() async {
    try {
      setState(() {
        isLoadingpricing = true;
      });
      final _pricing = await Kaimly.server
          .items(collection: 'membership_plan', sort: 'sort=duration_months');
      // print(_pricing);
      setState(() {
        pricing = PricingModel.convertlist(_pricing);
        isLoadingpricing = false;
      });
    } catch (e) {
      setState(() {
        isLoadingpricing = false;
        print(e);
      });
    }
  }

  // var transactionInit;
  // Razorpay _razorpay = Razorpay();

  // // print("*********************************************88");
  // // print(response.paymentId);
  // // print("**********************************************");
  // onPaymentSuccess(PaymentSuccessResponse response) async {
  //   try {
  //     await Kaimly.server
  //         .customPostAPI(route: 'custom/payments/complete', body: {
  //       "payment_id": response.paymentId,
  //       "receipt": transactionInit['data']['razorpay']['receipt']
  //     });
  //     await Provider.of<MembershipProvider>(context, listen: false)
  //         .loadMemberShip();
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // openRazorpay(PricingModel item) async {
  //   try {
  //     final _transactionInit = await Kaimly.server.customPostAPI(
  //         route: 'custom/payments/init', body: {"membership_plan_id": item.id});
  //     transactionInit = _transactionInit;
  //     var options = {
  //       'key': gymRazorPayId,
  //       'amount': _transactionInit['data']['razorpay']['amount'],
  //       'name': item.name,
  //       'order_id': _transactionInit['data']['razorpay']['id'],
  //       'theme': {'hide_topbar': true}
  //     };
  //     _razorpay.open(options);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  @override
  void initState() {
    loadpricing();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onPaymentSuccess);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingpricing)
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          PricingShimmer(),
          PricingShimmer(),
          PricingShimmer(),
        ],
      );
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: pricing.length,
      itemBuilder: (ctx, index) {
        return InkWell(
            onTap: () {
              // openRazorpay(pricing[index]);
              Navigator.pushNamed(context, PricingDetails.routeName,
                  arguments: pricing[index]);
            },
            child: PricingItem(pricing: pricing[index]));
      },
    );
  }
}

class PricingItem extends StatelessWidget {
  PricingItem({Key? key, required this.pricing}) : super(key: key);
  final PricingModel pricing;

  @override
  Widget build(BuildContext context) {
    int total = (pricing.price * pricing.duration_months);
    int discount = (pricing.discount * pricing.duration_months);
    int offer = ((discount / total) * 100).toInt();

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            boxShadow: basicShadow,
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            offer > 0
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Text(
                      "$offer% OFF",
                      style: Theme.of(context).accentTextTheme.bodyText1!.merge(
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                    ),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹${pricing.price - pricing.discount}",
                        style: Theme.of(context).textTheme.headline6!.merge(
                            TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                      ),
                      Text(" / month",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .merge(TextStyle(fontSize: 12))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        pricing.name,
                        style: Theme.of(context).textTheme.headline6!.merge(
                            TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                      ),
                      Text("Membership",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .merge(TextStyle(fontSize: 12)))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
