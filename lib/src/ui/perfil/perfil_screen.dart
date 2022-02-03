import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/ui/perfil/components/perfil_body.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text("Mi perfil"),
      ),
      body: const PerfilBody(),
    );
  }
}