import 'dart:convert';

import 'package:parking/constants.dart';
import 'package:parking/src/models/vehicles_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  /*Future<List<VehiclesModel>> searchVehicles(String idDriver) async {
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
  }*/
  Future<List<VehiclesModel>> searchVehicles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt('userID');
    var url = urlAPI + '/vehicle/' + idUser.toString();
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

  Future<http.Response> deleteVehicle(String id) async{
    var url = urlAPI+'/vehicle/delete/'+id;
    final response = await http.delete(Uri.parse(url));
    //UserModel.fromJSON(jsonDecode(response.body));
    return response;
  }

  Future<http.Response> updateVehicle(VehiclesModel vehicle) async {
    Map data = {
      'tipoVehiculo': vehicle.typeVehicle,
      'placa': vehicle.licensePlate,
      'idConductor': vehicle.idDriver,
    };

    var url = urlAPI + '/vehicle/update/' +vehicle.licensePlate!;
    final response = await http.put(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(data));
    return response;
  }
}
