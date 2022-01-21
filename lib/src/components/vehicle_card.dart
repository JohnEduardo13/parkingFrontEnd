import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          const ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Vehiculo: Auto' ),
            subtitle: Text(
                'Placa: CZR 263'),
            leading: Icon(Icons.drive_eta),
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