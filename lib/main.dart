import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/bottom_navigation_bar.dart';
import 'package:parking/src/components/signup_form.dart';
import 'package:parking/src/services/login_state.dart';
import 'package:parking/src/ui/add_vehicles/add_vehicles_screen.dart';
import 'package:parking/src/ui/google_maps/maps_screen.dart';
import 'package:parking/src/ui/login/login_screen.dart';
import 'package:parking/src/ui/perfil/components/update_profile.dart';
import 'package:parking/src/ui/signup/signup_screen.dart';
import 'package:parking/src/ui/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool checkLogin = prefs.getBool("isLoggedIn") ?? false;
  runApp(MyApp(checkLogin));
}

class MyApp extends StatelessWidget {
  bool checkLogin;

  MyApp(this.checkLogin);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginState(),
        child: Consumer<LoginState>(
          builder: (context, loginState, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Parkeando',
              theme: ThemeData(
                primaryColor: kPrimaryColor,
                scaffoldBackgroundColor: Colors.white,
              ),
              initialRoute: checkLogin ? '/home' : '/welcome',
              routes: {
                '/welcome': (context) => const WelcomeScreen(),
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignUpScreen(),
                '/signForm': (context) => const SignupForm(),
                '/home': (context) => const BottomNavigation(),
                '/addVehicles': (context) => const AddVehiclesScreen(),
                '/updateProfile': (context) => const UpdateProfile(),
                '/Map': (context) => const MapsScreen(),
              }),
        ));
  }
}
