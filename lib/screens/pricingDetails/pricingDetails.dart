import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/PricingModel.dart';
import 'package:gym_user/core/providers/membershipProvider.dart';
import 'package:gym_user/core/providers/routeProvider.dart';
import 'package:gym_user/core/themes/gymData.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/DashBoard/dashBoard.dart';
import 'package:gym_user/screens/gym/widgets/pricing.dart';
import 'package:gym_user/widgets/customAppbar.dart';
import 'package:gym_user/widgets/customBtn.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PricingDetails extends StatefulWidget {
  static const routeName = "/pricing-details";

  @override
  _PricingDetailsState createState() => _PricingDetailsState();
}

class _PricingDetailsState extends State<PricingDetails> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isSuccess = false;

  var transactionInit;
  Razorpay _razorpay = Razorpay();

  // print("*********************************************88");
  // print(response.paymentId);
  // print("**********************************************");
  int repeate = 0;
  onPaymentSuccess(PaymentSuccessResponse response) async {
    if (repeate > 2) {
      return;
    }
    try {
      print("*********************************************88");
      print(response.paymentId);
      print("**********************************************");
      await Kaimly.server
          .customPostAPI(route: 'custom/payments/complete', body: {
        "payment_id": response.paymentId,
        "receipt": transactionInit['data']['razorpay']['receipt']
      });
      await Provider.of<MembershipProvider>(context, listen: false)
          .loadMemberShip();
      setState(() {
        _isInit = false;
        _isLoading = false;
        _isSuccess = true;
      });
    } catch (e) {
      print("********************************errr");
      print(e);
      print("**********************************************");
      setState(() {
        _isInit = true;
        _isLoading = false;
        _isSuccess = false;
        repeate = 1;
      });
      onPaymentSuccess(response);
      throw e;
    }
  }

  initPayment(PricingModel item) async {
    try {
      setState(() {
        _isInit = false;
        _isLoading = true;
      });
      final _transactionInit = await Kaimly.server.customPostAPI(
          route: 'custom/payments/init', body: {"membership_plan_id": item.id});
      transactionInit = _transactionInit;
      var options = {
        'key': gymRazorPayId,
        'amount': _transactionInit['data']['razorpay']['amount'],
        'name': item.name,
        'order_id': _transactionInit['data']['razorpay']['id'],
        'theme': {'hide_topbar': true}
      };
      _razorpay.open(options);
    } catch (e) {
      throw e;
    }
  }

  onPaymentErr(PaymentFailureResponse response) {
    setState(() {
      _isInit = true;
      _isLoading = false;
      _isSuccess = false;
    });
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onPaymentErr);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PricingModel pricing =
        ModalRoute.of(context)!.settings.arguments as PricingModel;
    int totalprice = (pricing.price * pricing.duration_months) -
        (pricing.discount * pricing.duration_months);
    int tax = ((totalprice * 18) / (100 + 18)).toInt();
    int subtotal = ((totalprice * 100) / (100 + 18)).toInt();

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: _isLoading
          ? SizedBox.shrink()
          : CustomBtn(
              label: _isSuccess ? "Return to Home" : "Buy Now",
              onPressed: _isSuccess
                  ? () {
                      Provider.of<RouteProvider>(context, listen: false)
                          .controller
                          .animateTo(0);
                      Navigator.pop(context);
                    }
                  : () {
                      initPayment(pricing);
                    },
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.only(
                bottom: 25,
                left: 25,
                right: 25,
              ),
            ),
      appBar: customAppbar(context, label: pricing.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            PricingItem(pricing: pricing),
            Container(
                margin: const EdgeInsets.only(top: 15),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    boxShadow: basicShadow,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SubDetails(
                      label: "QTY",
                      price: pricing.duration_months,
                      isMonth: true,
                    ),
                    SubDetails(
                      label: "Rate",
                      price: pricing.price,
                    ),
                    SubDetails(
                      label: "Discount",
                      price: pricing.discount,
                    ),
                    SubDetails(
                      label: "Sub total",
                      price: subtotal,
                    ),
                    SubDetails(
                      label: "GST 18%",
                      price: tax,
                    ),
                    SubDetails(
                      label: "Total",
                      price: totalprice,
                      bold: true,
                    ),
                  ],
                )),
            Text(
              "\nBy purchasing our plan you are agree to our Privacy Policy, Terms and Conditions and Refund Policy",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .merge(TextStyle(fontSize: 10)),
            ),
            _isInit
                ? SizedBox.shrink()
                : _isLoading
                    ? Container(
                        margin: const EdgeInsets.only(top: 70),
                        child: CircularProgressIndicator(),
                      )
                    : _isSuccess
                        ? Successful()
                        : SizedBox.shrink(),
          ],
        ),
      ),
    ));
  }
}

class Successful extends StatelessWidget {
  const Successful({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/success.png",
                height: 270,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 45),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10)),
                height: 172,
                width: 210,
                // child: SizedBox(),
                child: Lottie.asset('assets/animations/success2.json',
                    repeat: false, height: 160),
              ),
            )
          ],
        ));
  }
}

class SubDetails extends StatelessWidget {
  final String label;
  final int price;
  final bool isMonth;
  final bool bold;

  SubDetails(
      {required this.label,
      required this.price,
      this.isMonth = false,
      this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1!.merge(
                  TextStyle(
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                    fontSize: bold ? 14 : 12,
                  ),
                ),
          ),
          Text(isMonth ? "${price.toString()}" : " ₹ ${price.toString()}",
              style: Theme.of(context).textTheme.subtitle2!.merge(
                    TextStyle(
                      fontSize: bold ? 14 : 12,
                    ),
                  )),
        ],
      ),
    );
  }
}
