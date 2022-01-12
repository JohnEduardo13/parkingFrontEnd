import 'package:flutter/material.dart';
import 'package:parking/src/ui/google_maps/componets/maps_body.dart';

class MapsScreen extends StatelessWidget{
  const MapsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: MapsBody(),
    );
  }
}