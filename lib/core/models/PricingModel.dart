class PricingModel {
  final String id;
  final String name;
  final int price;
  final int discount;
  final int duration_months;

  PricingModel({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.duration_months,
  });

  static PricingModel convert(Map data) {
    return PricingModel(
      id: data['id'],
      name: data['name'],
      price: data['price'],
      discount: data['discount'],
      duration_months: data['duration_months'],
    );
  }

  static List<PricingModel> convertlist(dynamic data) {
    dynamic _pricings = data['data'];
    List<PricingModel> pricings = [];
    for (var data in _pricings) {
      pricings.add(PricingModel.convert(data));
    }
    return pricings;
  }
}
