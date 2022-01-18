class ParkingModel {
  final int idParking;
  final String barrio;
  final String direccion;
  final int telefono;
  final int cupoTotal;
  final int cupoActual;
  final int idPropietario;
  final double locX;
  final double locY;

  ParkingModel(
    this.idParking,
    this.barrio,
    this.direccion,
    this.telefono,
    this.cupoTotal,
    this.cupoActual,
    this.idPropietario,
    this.locX,
    this.locY);

   ParkingModel.fromJson(Map<String, dynamic> parsedJson, this.idParking, this.barrio, this.direccion, this.telefono, this.cupoTotal, this.cupoActual, this.idPropietario, this.locX, this.locY){
    idParking: parsedJson['id_parqueadero'];
    barrio: parsedJson['barrio'];
    direccion: parsedJson['direccion'];
    telefono: parsedJson['telefono'];
    cupoTotal: parsedJson['cupo_total'];
    cupoActual: parsedJson['cupo_actual'];
    idPropietario: parsedJson['id_propietario'];
    locX: parsedJson['loc_x'];
    locY: parsedJson['loc_y'];
  }
}