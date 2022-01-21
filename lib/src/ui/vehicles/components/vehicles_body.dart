import 'package:flutter/material.dart';
import 'package:parking/src/components/vehicle_card.dart';

class VehiclesBody extends StatelessWidget {
  const VehiclesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        VehicleCard(),
      ],
    );
  }
}