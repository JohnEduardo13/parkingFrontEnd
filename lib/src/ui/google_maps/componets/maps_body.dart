import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parking/src/components/marker_description.dart';
import 'package:parking/src/resources/parking_repository.dart';
import 'package:parking/constants.dart';

const double pinVisibleTime = 20;
const double pinInvisibleTime = -220;

class MapsBody extends StatelessWidget {
  const MapsBody({Key? key}) : super(key: key);

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
  ParkingRepository parkingRepo = ParkingRepository();

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Position? currentPosition;
  var geolocator = Geolocator();
  late GoogleMapController newGoogleMapController;
  double pinPillPosition = pinInvisibleTime;
  double bottomPaddingOfMap = 0;

  String neighborhood = '';
  String direction = '';
  int currentLimit = 0;
  int totalLimit = 0;

  double currentLat = 0.0;
  double currentLng = 0.0;
  double destinationLat = 0.0;
  double destinationLng = 0.0;

  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  bool polyVisibility = false;

  /*@override
  void initState() {
    super.initState();
    
  }*/

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    currentLat = position.latitude;
    currentLng = position.longitude;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 18);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<Set<Marker>> createMarkers() async {
    List<Marker> markes = [];

    var urlParking = urlAPI + '/parkingLot/all';
    final response = await http.get(Uri.parse(urlParking));
    final responseBody = jsonDecode(response.body);
    if (responseBody.length > 0) {
      for (int i = 0; i < responseBody.length; i++) {
        if (responseBody[i] != null) {
          Map<String, dynamic> map = responseBody[i];
          double x = map['locX'];
          double y = map['locY'];
          String neighborhoodData = map['barrio'];
          String directionData = map['direccion'];
          int currentLimitData = map['cupoActual'];
          int totalLimitData = map['cupoTotal'];
          markes.add(
            Marker(
              markerId: MarkerId(map['idParqueadero'].toString()),
              position: LatLng(x, y),
              flat: true,
              onTap: () {
                setState(() {
                  pinPillPosition = pinVisibleTime;
                  neighborhood = neighborhoodData;
                  direction = directionData;
                  currentLimit = currentLimitData;
                  totalLimit = totalLimitData;
                  destinationLat = x;
                  destinationLng = y;
                  polyVisibility = true;
                  polylines.clear();
                  polylineCoordinates.clear();
                });
                setPolylines(destinationLat, destinationLng);
              },
              /*infoWindow: InfoWindow(
                title: title,
                snippet: "Cupo $currentLimit/$totalLimit",
              ),*/
              icon: BitmapDescriptor.defaultMarker,
            ),
          );
        }
      }
    }
    return markes.toSet();
  }

  @override
  Widget build(BuildContext context) {
    //UserModel user = UserModel();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: createMarkers(), //parkingRepo.createMarkers(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Scaffold(
                  body: Stack(
                    children: [
                      Positioned.fill(
                        child: GoogleMap(
                          //padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
                          mapType: MapType.normal,
                          markers: snapshot.data,
                          compassEnabled: false,
                          polylines: polylines,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          mapToolbarEnabled: false,
                          initialCameraPosition: const CameraPosition(
                              target: LatLng(0.0, 0.0), zoom: 10),
                          onTap: (LatLng loc) {
                            setState(() {
                              pinPillPosition = pinInvisibleTime;
                              polyVisibility = false;
                              polylines.clear();
                              polylineCoordinates.clear();
                              //polylines.remove(true);
                            });
                          },
                          onMapCreated: (GoogleMapController controller) {
                            newGoogleMapController = controller;
                            _controllerGoogleMap.complete(controller);

                            locatePosition();
                            setPolylines(destinationLat, destinationLng);
                          },
                          /*initialCameraPosition: const CameraPosition(
                              target: LatLng(3.433704, -76.464625), zoom: 10),*/
                        ),
                      ),
                      AnimatedPositioned(
                        child: MarkerDescription(neighborhood:neighborhood,direction:direction,currentLimit:currentLimit,totalLimit:totalLimit),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        left: 0,
                        right: 0,
                        bottom: pinPillPosition,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void setPolylines(double lat, double lng) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCsVBLSHAT-dR6aQY3r9xxWz563lqUuVHM",
      PointLatLng(
        currentLat,
        currentLng
      ),
      PointLatLng(
        lat,
        lng
      ),
      travelMode: TravelMode.driving,
    );

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        polylines.add(
          Polyline(
            width: 5,
            polylineId: const PolylineId('polyLine'),
            color: const Color(0xFF4C08CB),
            points: polylineCoordinates
          )
        );
      });
    }
  }


}
