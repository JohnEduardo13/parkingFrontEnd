import 'package:parking/src/models/parking_model.dart';

class GoogleMapsState{
  final ParkingModel? parking;
  const GoogleMapsState({this.parking});

  factory GoogleMapsState.initial() => const GoogleMapsState();
}

class Loading extends GoogleMapsState {}
class Successfull extends GoogleMapsState {}
class Error extends GoogleMapsState {
  String error;
  Error(this.error);
}