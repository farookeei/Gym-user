import 'package:flutter/material.dart';
import 'package:gym_user/core/models/PricingModel.dart';
import 'package:gym_user/core/models/transaction_model.dart';
import 'package:gym_user/core/themes/theme.dart';
import 'package:gym_user/screens/transcations/transactionDetail.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transactionDetail;

  TransactionItem({
    required this.transactionDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: basicShadow,
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return TransactionDetail(
              transactionDetail: transactionDetail,
            );
          }));
        },
        title: Text(
          transactionDetail.pricingModel.name,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .merge(TextStyle(fontSize: 15)),
        ),
        subtitle: Text(
          "#NO ${transactionDetail.orderId}",
          style: Theme.of(context).textTheme.caption,
        ),
        trailing: Text("₹${transactionDetail.amountpaid}",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .merge(TextStyle(fontWeight: FontWeight.w700))),
      ),
    );
  }
}
