import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/vehicle_card.dart';
import 'package:parking/src/models/vehicles_model.dart';
import 'package:parking/src/resources/vehicles_repository.dart';
import 'package:parking/src/ui/add_vehicles/components/add_vehicles_form.dart';

class VehiclesBody extends StatefulWidget {
  const VehiclesBody({Key? key}) : super(key: key);

  @override
  State<VehiclesBody> createState() => _VehiclesBodyState();
}

class _VehiclesBodyState extends State<VehiclesBody> {
  List<VehiclesModel> vehicles = <VehiclesModel>[];
  VehiclesRepository vehiclesRepo = VehiclesRepository();
  bool loading = true;
  int? idUser;

  getVehicles() {
    vehiclesRepo.searchVehicles().then((value) {
      setState(() {
        vehicles.addAll(value);
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
        child: loading
            ? FutureBuilder(
                future: vehiclesRepo.searchVehicles(),
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
