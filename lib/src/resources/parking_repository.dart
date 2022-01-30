import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:parking/src/models/parking_model.dart';

class ParkingRepository{
  Client client = Client();

  Future<Set<Marker>> createMarkers() async{
    List<Marker> markers =[];
    var urlParking = 'http://2308-181-50-102-111.ngrok.io/parkingLot/all';
    final response = await client.get(Uri.parse(urlParking));
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      if(responseBody.length > 0){
        List<ParkingModel> data = responseBody.map((user) => ParkingModel.fromJSON(user)).toList();
        for(int i = 0; i < data.length; i++){
          if(responseBody[i] != null){
            Map<String, dynamic> map = responseBody[i];
            double x = map[data[i].locX];
            double y = map[data[i].locY];
            markers.add(
              Marker(
                markerId: MarkerId(map[data[i].idParking].toString()),
                position: LatLng(x, y),
              ),
            );
          }
        }
      }
      return markers.toSet();
    }else{
      throw Exception('Failed to load data');
    }
  }
}