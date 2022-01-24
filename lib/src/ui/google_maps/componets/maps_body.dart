import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parking/src/models/parking_model.dart';

/*class MapsBody extends StatefulWidget {
  const MapsBody({Key? key}) : super(key: key);

  @override
  State<MapsBody> createState() => _MapsBodyState();
}

class _MapsBodyState extends State<MapsBody> {
  final Set<Marker> _markers = {};

  void _onAddMarker() {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId("parqueadero 1"),
          position: LatLng(3.435717, -76.468333),
          infoWindow: InfoWindow(
            title: "Parqueadero libre",
            snippet: "Cupo 15/30",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(3.433704, -76.464625), zoom: 15),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          double mq1 = MediaQuery.of(context).devicePixelRatio;
          _onAddMarker();
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(3.435717, -76.468333),
                zoom: 15.0,
              ),
            ),
          );
        }));
  }
}*/

class MapsBody extends StatelessWidget {
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
    //late Future _future;

    Future<Set<Marker>> createMarkers() async {
      List<Marker> markes = [];

      var urlParking = 'http://0346-181-50-102-111.ngrok.io/parkingLot/all';
      final response = await http.get(Uri.parse(urlParking));
      final responseBody = jsonDecode(response.body);
      if(responseBody.length > 0){
        for(int i = 0; i < responseBody.length; i++){
          if(responseBody[i] != null){
            Map<String, dynamic> map = responseBody[i];
            double x = map['locX'];
            double y = map['locY'];
            markes.add(
              Marker(
                markerId: MarkerId(map['idParqueadero'].toString()),
                position: LatLng(x, y),
              ),
            );
          }
        }
      }
      return markes.toSet();
    }

    /*Future <List<ParkingModel>> loadAPI() async{
      try{
        var urlParking = 'http://7b93-181-50-102-111.ngrok.io/parkingLot/all';
        final response = await http.get(Uri.parse(urlParking));
        final responseBody = jsonDecode(response.body);
        return responseBody;
      }catch (e){
        return [];
      }
    }*/

    /*List<Marker> allMarkers = [];

    loadLocations() async {
      List<ParkingModel> locations = [];
      locations = await get
    }
    late GoogleMapController _controller;

    @override
    void initState() {
      super.initState();
      _future = loadAPI();
    }*/
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: createMarkers(),
                builder: (context, AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GoogleMap(
                    mapType: MapType.normal,
                    markers: snapshot.data,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(3.433704, -76.464625), zoom: 10),
                    /*initialCameraPosition: const CameraPosition(
                      target: LatLng(40.7128, -74.0060), zoom: 1.0),
                      markers: Set.from(allMarkers),
                      onMapCreated: mapCreated,
                      mapType: MapType.normal,

                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      myLocationEnabled: true,*/
                      );
                },
              ),
            ),
          ],
        ),
      );
    }

    /*void mapCreated(controller){
      setState(() {
        _controller = controller;
      });
    }*/
}

