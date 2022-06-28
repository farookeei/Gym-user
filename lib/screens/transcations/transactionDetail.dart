import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_user/core/models/transaction_model.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/allScreens.dart';
import 'package:gym_user/screens/transcations/widgets/transactionItem.dart';
import 'package:gym_user/widgets/customAppbar.dart';

class TransactionDetail extends StatelessWidget {
  final TransactionModel transactionDetail;

  TransactionDetail({required this.transactionDetail});

  static const routename = "/trans-detail";
  @override
  Widget build(BuildContext context) {
    var originalRate = (transactionDetail.pricingModel.price *
        transactionDetail.pricingModel.duration_months);
    return Scaffold(
      appBar: customAppbar(context, label: "#NO 33"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            TransactionItem(
              transactionDetail: transactionDetail,
            ),
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
                    // SubDetails(label: "Date", price: 44),
                    SubDetails(
                        isMonth: true,
                        label: "Total months",
                        price: transactionDetail.pricingModel.duration_months),
                    SubDetails(
                        label: "rate per month",
                        price: transactionDetail.pricingModel.price),
                    SubDetails(label: "original rate", price: originalRate),
                    SubDetails(
                        label: "Discount", price: transactionDetail.discount),
                    // SubDetails(label: "label", price: 44),
                    SubDetails(
                        label: "Total",
                        price: transactionDetail.totalPrice,
                        bold: true),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
