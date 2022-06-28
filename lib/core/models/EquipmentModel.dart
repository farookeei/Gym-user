import 'package:hive/hive.dart';

class EquipmentModel {
  final int id;
  final String image;
  final String description;

  EquipmentModel({
    required this.id,
    required this.image,
    required this.description,
  });

  static EquipmentModel convert(Map data) {
    return EquipmentModel(
      id: data['id'],
      image: data['image'],
      description: data['description'],
    );
  }

  static List<EquipmentModel> convertlist(dynamic data) {
    dynamic _equipments = data['data'];
    List<EquipmentModel> equipments = [];
    for (var data in _equipments) {
      equipments.add(EquipmentModel.convert(data));
    }
    return equipments;
  }
}
