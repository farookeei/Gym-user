import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/transaction_model.dart';
import 'package:gym_user/widgets/customAppbar.dart';
import 'package:gym_user/widgets/shimmers/transactionShimmer.dart';

import 'widgets/transactionItem.dart';

class Transaction extends StatefulWidget {
  static const routeName = "/transcation";

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool _isLoading = false;
  List<TransactionModel> _transactionList = [];
  Future<void> loadTransaction() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final _fetchData = await Kaimly.server
          .items(collection: "transaction", fields: 'fields=*.*');
      print(_fetchData);
      _transactionList = TransactionModel.convertList(_fetchData);
      setState(() => _isLoading = false);
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppbar(context, label: "Transaction"),
            body: _isLoading
                ? ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    children: [
                      TransactionShimmer(),
                      TransactionShimmer(),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    itemCount: _transactionList.length,
                    itemBuilder: (ctx, i) {
                      return TransactionItem(
                        transactionDetail: _transactionList[i],
                      );
                    })));
  }
}
