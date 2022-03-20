import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/vehicle_card.dart';
import 'package:parking/src/models/vehicles_model.dart';
import 'package:parking/src/resources/vehicles_repository.dart';
import 'package:parking/src/services/login_state.dart';
import 'package:parking/src/ui/add_vehicles/components/add_vehicles_form.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehiclesBody extends StatefulWidget {
  const VehiclesBody({Key? key}) : super(key: key);

  @override
  State<VehiclesBody> createState() => _VehiclesBodyState();
}

class _VehiclesBodyState extends State<VehiclesBody> {
  List<VehiclesModel> vehicles = <VehiclesModel>[];
  VehiclesRepository vehiclesRepo = VehiclesRepository();
  bool loading = true;
  bool load = false;
  int? idUser;

  Future<int?> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt('userID');
    print('Obtener id $idUser');
    load = true;
    return idUser;
  }

  getVehicles() {
    print('Obtener vehiculos $idUser');
    vehiclesRepo.searchVehicles(idUser.toString()).then((value) {
      setState(() {
        print('Obtener id $idUser');
        vehicles.addAll(value);
        loading = false;
      });
    });
  }

  /*Future<List<VehiclesModel>> getVehicles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt('userID');
    vehiclesRepo.searchVehicles(idUser.toString()).then((value) {
      setState(() {
        vehicles.addAll(value);
        loading = false;
      });
    });
    return vehicles;
  }*/

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
     await getVehicles();
    });
    getIdUser();
    //idUser = Provider.of<LoginState>(context, listen: false).currentIdUser();
    super.initState();
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
        child: loading
            ? FutureBuilder(
                future: vehiclesRepo.searchVehicles(idUser.toString()),
                builder:
                    (context, AsyncSnapshot<List<VehiclesModel>> snapshot) {
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
                })
            : const Center(
                child: CircularProgressIndicator(),
              ),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const VehiclesForm()));
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
