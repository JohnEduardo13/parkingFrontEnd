import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/ui/google_maps/componets/maps_body.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text("Mi Mapa"),
      ),
      body: const MapsBody(),
    );
  }
}
