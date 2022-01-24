class ParkingModel {
  int _idParking = 0;
  String _barrio = '';
  String _direccion = '';
  int _telefono = 0;
  int _cupoTotal = 0;
  int _cupoActual = 0;
  int _idPropietario = 0;
  double _locX = 0;
  double _locY = 0;

  ParkingModel.fromJson(Map<String, dynamic> parsedJson){
    _idParking = parsedJson['id_parqueadero'];
    _barrio = parsedJson['barrio'];
    _direccion = parsedJson['direccion'];
    _telefono = parsedJson['telefono'];
    _cupoTotal = parsedJson['cupo_total'];
    _cupoActual = parsedJson['cupo_actual'];
    _idPropietario = parsedJson['id_propietario'];
    _locX = parsedJson['loc_x'];
    _locY = parsedJson['loc_y'];
  }

  int get idParking => _idParking;
  String get barrio => _barrio;
  String get direccion => _direccion;
  int get telefono => _telefono;
  int get cupoTotal => _cupoTotal;
  int get cupoActual => _cupoActual;
  int get idPropietario => _idPropietario;
  double get loceXe => _locX;
  double get locY => _locY;
}