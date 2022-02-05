import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking/constants.dart';
import 'package:parking/src/models/user_model.dart';

class UserRepository{
  UserModel user = UserModel();

  Future<http.Response> registerUSer(UserModel user) async{
    Map data = {
      'usuario': user.user,
      'password': user.password,
      'rol': 2,
    };

    var url = urlAPI+'/user/save';
    final response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(data));
    return response;
  }

  Future<http.Response> searchUser(String email) async{
    var url = urlAPI+'/user/'+email;
    final response = await http.get(Uri.parse(url));
    //UserModel.fromJSON(jsonDecode(response.body));
    return response;
  }

  Future<UserModel> searchUserData(String email) async{
    var url = urlAPI+'/user/'+email;
    final response = await http.get(Uri.parse(url));
    return UserModel.fromJSON(jsonDecode(response.body));
  }

}