import 'package:flutter/material.dart';
import 'package:parking/src/components/or_divider.dart';

class PerfilBody extends StatelessWidget {
  const PerfilBody({Key? key}) : super(key: key);

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
              margin: const EdgeInsets.fromLTRB(35,40,35,20),
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
              children: const <Widget>[
                Text("Jhon Eduardo Zuñiga Ruiz", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("jhon13@gmail.com"),
                Text("3194940992"),
              ],),
          ),
          const OrDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(35,10,35,10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: const Text("Editar Perfil"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: const Text("Editar Contraseña"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const OrDivider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(35,10,35,35),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.exit_to_app,
                      color: Colors.grey,
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: const Text("Cerrar Sesiòn"),
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