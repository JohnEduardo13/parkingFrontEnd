import 'package:flutter/material.dart';
import 'package:parking/src/components/vehicle_card.dart';
import 'package:parking/src/models/vehicles_model.dart';
import 'package:parking/src/resources/vehicles_repository.dart';
import 'package:parking/src/ui/add_vehicles/add_vehicles_screen.dart';

class VehiclesBody extends StatefulWidget {
  const VehiclesBody({Key? key}) : super(key: key);

  @override
  State<VehiclesBody> createState() => _VehiclesBodyState();
}

class _VehiclesBodyState extends State<VehiclesBody> {
  List<VehiclesModel> vehicles = <VehiclesModel>[];
  VehiclesRepository vehiclesRepo = VehiclesRepository();
  bool loading = true;
  String id = '123456';

  @override
  void initState() {
    super.initState();
    vehiclesRepo.searchVehicles(id).then((value) {
      setState(() {
        vehicles.addAll(value);
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        ' Esta vacio ${vehicles.isNotEmpty},${vehicles.isEmpty}, ${vehicles.length}');
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(bottom: 90),
        child: Center(
            child: loading == true
                ? const Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: vehicles.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(
                          ' Esta vacio ${vehicles.isEmpty}, ${vehicles.length}');
                      if (vehicles.isNotEmpty) {
                        return VehicleCard(
                            type: vehicles[index].typeVehicle,
                            licensePlate: vehicles[index].licensePlate);
                      } else {
                        print('no hay nada');
                        return const Center(
                          child: Text('No data found, tap plus button to add!',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }
                    })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const AddVehiclesScreen();
            }),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
