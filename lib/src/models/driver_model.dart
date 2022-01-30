class DriverModel{
  int? document;
  String? name;
  String? lastName;
  String? email;
  String? phone;

  DriverModel({
    this.document,
    this.name,
    this.lastName,
    this.email,
    this.phone,
  });

  factory DriverModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = DriverModel(
      document: jsonMap['cedula'],
      name: jsonMap['nombre'],
      lastName: jsonMap['apellido'],
      email: jsonMap['correo'],
      phone: jsonMap['telefono'],
    );
    return data;
  }
}