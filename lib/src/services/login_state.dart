import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking/src/resources/driver_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
  bool loggedIn = false;
  bool isLoggedIn() => loggedIn;

  final FirebaseAuth auth = FirebaseAuth.instance;
  DriverRepository driver = DriverRepository();
  User? user;
  int? idUser;
  String? currentUser() => user!.email;
  int? currentIdUser() => idUser;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late SharedPreferences loginData;
  late bool loginState = false;

  void login(String email, String password) async {
    final SharedPreferences prefsState = await prefs;
    user = await signIn(email, password);
    await driver.searchDriverForEmail(email).then((value) {
      idUser = value.document;
    });
    if (user != null) {
      loggedIn = true;
      prefsState.setBool('isLoggedIn', loggedIn);
      prefsState.setInt('userID', idUser!);
      print('Estado del logueo $loggedIn Usuario $user Id $idUser');
      notifyListeners();
    } else {
      loggedIn = false;
      idUser = 0;
      prefsState.setBool('isLoggedIn', loggedIn);
      prefsState.setInt('userID', idUser!);
      //print(loggedIn);
      notifyListeners();
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefsState = await prefs;
    loggedIn = false;
    idUser = 0;
    prefsState.setBool('isLoggedIn', loggedIn);
    prefsState.setInt('userID', idUser!);
    print('Deslogueo $loggedIn');
    notifyListeners();
  }

  Future<bool> getLoginState() async{
    final SharedPreferences prefsState = await prefs;
    prefsState.getBool('isLoggedIn');
    return loginState;
  }

  Future<User?> signIn(String email, String password) async {
    User? user;
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    user = result.user;
    return user;
  }
}
