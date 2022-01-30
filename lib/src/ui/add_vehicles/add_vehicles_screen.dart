import 'package:flutter/material.dart';
import 'package:parking/src/ui/add_vehicles/components/add_vehicles_form.dart';

class AddVehiclesScreen extends StatelessWidget {
  const AddVehiclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VehiclesForm(),
    );
  }
}