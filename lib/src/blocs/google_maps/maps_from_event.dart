import 'package:equatable/equatable.dart';

abstract class GoogleMapsEvent extends Equatable{
  const GoogleMapsEvent();

  @override 
  List<Object> get props => [];
}

class GetMarker extends GoogleMapsEvent {}