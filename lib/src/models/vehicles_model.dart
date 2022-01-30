class VehiclesModel{
  String? typeVehicle;
  String? licensePlate;
  int? idDriver;

  VehiclesModel({
    this.typeVehicle,
    this.licensePlate,
    this.idDriver,
  });

  factory VehiclesModel.fronJSON(Map<String,dynamic> jsonMap){
    final data = VehiclesModel(
      typeVehicle: jsonMap['tipoVehiculo'],
      licensePlate: jsonMap['placa'],
      idDriver: jsonMap['idConductor']
    );
    return data;
  }
}