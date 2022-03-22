import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/bottom_navigation_bar.dart';
import 'package:parking/src/components/or_divider.dart';
import 'package:parking/src/resources/driver_repository.dart';
import 'package:parking/src/services/login_state.dart';
import 'package:parking/src/ui/login/login_screen.dart';
import 'package:parking/src/ui/perfil/components/update_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilBody extends StatefulWidget {
  const PerfilBody({Key? key}) : super(key: key);

  @override
  State<PerfilBody> createState() => _PerfilBodyState();
}

class _PerfilBodyState extends State<PerfilBody> {
  BottomNavigation onTap = const BottomNavigation();
  DriverRepository user = DriverRepository();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  int? idUser;
  String userFullName = '';
  String userEmail = '';
  String userMobile = '';

  getData() {
    user.searchDriver().then((response) {
      setState(() {
        userFullName = response.name! + " " + response.lastName!;
        userEmail = response.email!;
        userMobile = response.phone!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //idUser = Provider.of<LoginState>(context, listen: false).currentIdUser();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.fromLTRB(35, 40, 35, 20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/perfil_2.png',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: <Widget>[
                  Text(userFullName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(userEmail),
                  Text(userMobile),
                ],
              ),
            ),
            const OrDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      TextButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, 'updateProfile');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdateProfile()));
                        },
                        child: const Text("Editar Perfil",
                            style: TextStyle(color: kPrimaryLightColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const OrDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 10, 35, 35),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.exit_to_app,
                        color: kPrimaryColor,
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<LoginState>(context, listen: false)
                              .logout();
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text("Cerrar Sesión",
                            style: TextStyle(color: kPrimaryLightColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
