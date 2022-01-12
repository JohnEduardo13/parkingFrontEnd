import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsBody extends StatelessWidget {
  const MapsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LatLng latLng = LatLng(37.4275, -122.1472);
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