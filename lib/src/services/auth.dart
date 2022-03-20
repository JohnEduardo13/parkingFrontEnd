import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/src/models/user_model.dart';

class AuthService{

  //final FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? userFromFirebaseUser(User? user) {
    if (user != null) {
      return UserModel(user: user.email);
    } else {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      return null;
    } 
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return userFromFirebaseUser(user);
    } catch (error) {
      return null;
    } 
  }

  Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (error) {
      return null;
    }
  }

}