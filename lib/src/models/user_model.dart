class UserModel{
  String? user;
  String? password;
  int? rol;

  UserModel({
    this.user,
    this.password,
    this.rol
  });

  factory UserModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = UserModel(
      user: jsonMap['usuario'],
      password: jsonMap['password'],
      rol: jsonMap['rol']
    );
    return data;
  }
}