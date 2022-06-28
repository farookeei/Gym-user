import 'package:gym_user/core/models/PricingModel.dart';

class TransactionModel {
  final String id;
  final String orderId;
  final int amountpaid;
  final int discount;
  final int totalPrice;
  final PricingModel pricingModel;

  TransactionModel(
      {required this.amountpaid,
      required this.totalPrice,
      required this.discount,
      required this.id,
      required this.pricingModel,
      required this.orderId});

  static TransactionModel convert(Map data) {
    return TransactionModel(
        totalPrice: data["totalprice"],
        discount: data["discount"],
        amountpaid: data["paidamount"],
        id: data["id"],
        pricingModel: PricingModel.convert(data["membership"]),
        orderId: data["order_id"]);
  }

  static List<TransactionModel> convertList(dynamic data) {
    List<TransactionModel> _transactions = [];
    for (var item in data["data"]) {
      _transactions.add(TransactionModel.convert(item));
    }
    return _transactions;
  }
}
