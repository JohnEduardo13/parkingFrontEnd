import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parking/src/models/parking_model.dart';

class MapsBody extends StatelessWidget {
  const MapsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LatLng latLng = const LatLng(37.4275, -122.1472);
    CameraPosition cameraPosition = CameraPosition(target: latLng);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: GoogleMap(
                    initialCameraPosition: cameraPosition,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class MapsBody extends StatelessWidget {
  const MapsBody({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyMapsPage(),
    );
  }
}

class MyMapsPage extends StatefulWidget {
  const MyMapsPage({Key? key}) : super(key: key);

  @override
  _MyMapsPageState createState() => _MyMapsPageState();
}

class _MyMapsPageState extends State<MyMapsPage> {
    late Future _future;

    Future <ParkingModel> loadAPI() async{
      var urlParking = 'http://7b93-181-50-102-111.ngrok.io/parkingLot/all';
      var response = await http.get(Uri.parse(urlParking));
      final responseBody = jsonDecode(response.body);
      return ParkingModel.fromJson(responseBody[0]);
    }

    List<Marker> allMarkers = [];
    late GoogleMapController _controller;

    @override
    void initState() {
      super.initState();
      _future = loadAPI();
    }
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: _future,
                builder: (context, AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<dynamic> parsedJson = jsonDecode(snapshot.data);

                  allMarkers = parsedJson.map((i) {
                    return Marker(
                      markerId: MarkerId(i['id_parqueadero']),
                      position: LatLng(i['loc_x'], i['loc_y']),
                      );
                  }).toList();

                  return GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(40.7128, -74.0060), zoom: 1.0),
                      markers: Set.from(allMarkers),
                      onMapCreated: mapCreated,
                      mapType: MapType.normal,

                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      myLocationEnabled: true,
                      );
                },
              ),
            ),
          ],
        ),
      );
    }

    void mapCreated(controller){
      setState(() {
        _controller = controller;
      });
    }
}*/


