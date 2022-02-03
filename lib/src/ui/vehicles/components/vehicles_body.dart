import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
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
  String id = '119421';

  getVehicles() {
    vehiclesRepo.searchVehicles(id).then((value) {
      setState(() {
        vehicles.addAll(value);
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getVehicles();
  }

  _isDelete(bool value) {
    setState(() {
      if (value) {
        getVehicles();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(bottom: 90),
        child: FutureBuilder(
            future: vehiclesRepo.searchVehicles(id),
            builder: (context, AsyncSnapshot<List<VehiclesModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, index) => InkWell(
                        child: VehicleCard(
                          licensePlate: snapshot.data![index].licensePlate,
                          type: snapshot.data![index].typeVehicle,
                          action: _isDelete,
                        ),
                      ));
            }),
      ),
      /*body: Container(
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
                      if (vehicles.isNotEmpty) {
                        return VehicleCard(
                            type: vehicles[index].typeVehicle,
                            licensePlate: vehicles[index].licensePlate);
                      } else {
                        return const Center(
                          child: Text('No data found, tap plus button to add!',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }
                    })),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const AddVehiclesScreen();
            }),
          );
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
