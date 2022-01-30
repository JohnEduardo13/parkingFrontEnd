import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  final String? type;
  final String? licensePlate;
  const VehicleCard({
    Key? key,
    required this.type,
    required this.licensePlate,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Vehiculo: $type' ),
            subtitle: Text(
                'Placa: $licensePlate'),
            leading: const Icon(Icons.drive_eta),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(onPressed: () => {}, child: const Text('Editar')),
              TextButton(onPressed: () => {}, child: const Text('Eliminar'))
            ],
          )
        ],
      ),
    );
  }
}