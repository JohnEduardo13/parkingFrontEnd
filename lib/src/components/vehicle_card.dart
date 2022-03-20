import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/resources/vehicles_repository.dart';

class VehicleCard extends StatefulWidget {
  final String? type;
  final String? licensePlate;
  final ValueChanged<bool> action;
  const VehicleCard(
      {Key? key,
      required this.type,
      required this.licensePlate,
      required this.action})
      : super(key: key);

  @override
  State<VehicleCard> createState() => VehicleCardState();
}

class VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    VehiclesRepository vehicleRepo = VehiclesRepository();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(15),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text('Vehiculo: ${widget.type}'),
              subtitle: Text('Placa: ${widget.licensePlate}'),
              leading: widget.type == 'Auto'
                  ? const Icon(Icons.drive_eta)
                  : const Icon(Icons.two_wheeler)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              /*TextButton(
                  onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VehiclesUpdate(
                            idVehicle: widget.licensePlate,
                            type: widget.type,
                          );
                        }))
                      },
                  child: const Text('Editar',
                      style: TextStyle(color: kPrimaryLightColor))),*/
              TextButton(
                  onPressed: () => {
                        vehicleRepo
                            .deleteVehicle(widget.licensePlate!)
                            .then((response) {
                          if (response.statusCode == 200) {
                            widget.action(true);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: kPrimaryLightColor,
                                    content: Text('Vehiculo eliminado',
                                        textAlign: TextAlign.center)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: kPrimaryLightColor,
                                    content: Text('Error al eliminar vehiculo',
                                        textAlign: TextAlign.center)));
                          }
                        })
                      },
                  child: const Text('Eliminar',
                      style: TextStyle(color: kPrimaryLightColor)))
            ],
          )
        ],
      ),
    );
  }
}
