import 'package:flutter/material.dart';
import 'package:gym_user/core/Kaimly/Kaimly.dart';
import 'package:gym_user/core/models/EquipmentModel.dart';
import 'package:gym_user/core/themes/theme.dart';

import 'package:gym_user/widgets/shimmers/equipmentsShimmer.dart';

class Equipments extends StatefulWidget {
  @override
  _EquipmentsState createState() => _EquipmentsState();
}

class _EquipmentsState extends State<Equipments> {
  bool isLoadingEquipment = false;
  List<EquipmentModel> equipments = [];

  loadEquipments() async {
    try {
      setState(() {
        isLoadingEquipment = true;
      });
      final _equipments = await Kaimly.server.items(collection: 'equipments');
      print(_equipments);
      setState(() {
        isLoadingEquipment = false;
        equipments = EquipmentModel.convertlist(_equipments);
      });
    } catch (e) {}
  }

  @override
  void initState() {
    loadEquipments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingEquipment)
      return Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        child: GridView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,

            // childAspectRatio: 3 / 3,
            mainAxisExtent: 200,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
          ),
          children: [
            EquipmentShimmer(),
            EquipmentShimmer(),
            EquipmentShimmer(),
            EquipmentShimmer(),
            EquipmentShimmer(),
            EquipmentShimmer(),
          ],
        ),
      );
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,

            // childAspectRatio: 3 / 3,
            mainAxisExtent: 200,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
          ),
          itemCount: equipments.length,
          itemBuilder: (ctx, i) {
            return EquipmentItem(equipment: equipments[i]);
          }),
    );
  }
}

class EquipmentItem extends StatelessWidget {
  const EquipmentItem({
    Key? key,
    required this.equipment,
  }) : super(key: key);

  final EquipmentModel equipment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            width: double.infinity,
            height: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                Kaimly.server.getFileUrl(
                  fileId: equipment.image,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            height: 60,
            // width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                equipment.description,
                style: Theme.of(context).accentTextTheme.bodyText1!.merge(
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
