import 'package:flutter/material.dart';
import 'package:parking/src/ui/vehicles/components/vehicles_body.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mis Vehiculos'),
      ),
      body: const VehiclesBody(),
    );
  }
}