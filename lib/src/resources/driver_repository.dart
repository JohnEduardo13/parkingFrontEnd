import 'dart:convert';

import 'package:parking/constants.dart';
import 'package:parking/src/models/driver_model.dart';
import 'package:http/http.dart' as http;
import 'package:parking/src/services/login_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverRepository {
  DriverModel driver = DriverModel();

  Future<http.Response> registerDriver(DriverModel driver) async {
    Map data = {
      'cedula': driver.document,
      'nombre': driver.name,
      'apellido': driver.lastName,
      'correo': driver.email,
      'telefono': driver.phone,
    };

    int id = driver.document!;

    var url = urlAPI + '/driver/save/' + id.toString();
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(data));
    return response;
  }

  Future<DriverModel> searchDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt('userID');
    final url = urlAPI + '/driver/id/' + idUser.toString();
    final response = await http.get(Uri.parse(url));
    return DriverModel.fromJSON(jsonDecode(response.body));
  }

  Future<DriverModel> searchDriverForEmail(String email) async {
    final url = urlAPI + '/driver/email/' + email;
    final response = await http.get(Uri.parse(url));
    return DriverModel.fromJSON(jsonDecode(response.body));
  }

  Future<http.Response> updateDriver(DriverModel driver) async {
    Map data = {
      'cedula': driver.document,
      'nombre': driver.name,
      'apellido': driver.lastName,
      'correo': driver.email,
      'telefono': driver.phone,
    };

    int id = driver.document!;

    var url = urlAPI + '/driver/update/' + id.toString();
    final response = await http.put(Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(data));
    return response;
  }
}
