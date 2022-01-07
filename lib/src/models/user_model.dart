class UserModel {
  String _user = '';
  String _pass = '';
  int _rol = 0;

  UserModel.fromJson(Map<String, dynamic> parsedJson){
    _user = parsedJson['usuario'];
    _pass = parsedJson['password'];
    _rol = parsedJson['rol'];
  }

  String get user => _user;
  String get pass => _pass;
  int get rol => _rol;
}