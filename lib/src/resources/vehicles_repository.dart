import 'dart:convert';

import 'package:parking/constants.dart';
import 'package:parking/src/models/vehicles_model.dart';
import 'package:http/http.dart' as http;

class VehiclesRepository {
  VehiclesModel vehicle = VehiclesModel();

  Future<http.Response> registerVehicle(VehiclesModel vehicle) async {
    Map data = {
      'tipoVehiculo': vehicle.typeVehicle,
      'placa': vehicle.licensePlate,
      'idConductor': vehicle.idDriver,
    };

    var url = urlAPI + '/vehicle/save';
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(data));
    return response;
  }

  /*Future<http.Response> searchVehicle(String idDriver) async{
    var url = urlAPI+'/vehicle/'+idDriver;
    final response = await http.get(Uri.parse(url));
    //UserModel.fromJSON(jsonDecode(response.body));
    return response;
  }*/

  Future<List<VehiclesModel>> searchVehicles(String idDriver) async {
    var url = urlAPI + '/vehicle/' + idDriver;
    final response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    var dataList = <VehiclesModel>[];

    if (response.statusCode == 200) {
      for (responseBody in responseBody) {
        dataList.add(VehiclesModel.fronJSON(responseBody));
      }
      return dataList;
    } else {
      throw Exception('Fail to get data');
    }
  }
}
