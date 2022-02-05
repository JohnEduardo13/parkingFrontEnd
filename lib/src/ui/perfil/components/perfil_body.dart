import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/or_divider.dart';
import 'package:parking/src/resources/driver_repository.dart';
import 'package:parking/src/ui/login/login_screen.dart';
import 'package:parking/src/ui/perfil/components/update_profile.dart';

class PerfilBody extends StatefulWidget {
  const PerfilBody({Key? key}) : super(key: key);

  @override
  State<PerfilBody> createState() => _PerfilBodyState();
}

class _PerfilBodyState extends State<PerfilBody> {
  DriverRepository user = DriverRepository();
  int id = 123456;
  String userFullName = '';
  String userEmail = '';
  String userMobile = '';

  @override
  void initState() {
    super.initState();
    user.searchDriver(id.toString()).then((response) {
      setState(() {
        userFullName = response.name! + " " + response.lastName!;
        userEmail = response.email!;
        userMobile = response.phone!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return UpdateProfile(id: id, email: userEmail,);
                          }),
                        ),
                      },
                      child: const Text("Editar Perfil",
                          style: TextStyle(color: kPrimaryLightColor)),
                    ),
                  ],
                ),
                /*Row(
                  children: <Widget>[
                    const Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: const Text("Editar Contraseña",
                          style: TextStyle(color: kPrimaryLightColor)),
                    ),
                  ],
                ),*/
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
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }),
                        ),
                      },
                      child: const Text("Cerrar Sesiòn",
                          style: TextStyle(color: kPrimaryLightColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
