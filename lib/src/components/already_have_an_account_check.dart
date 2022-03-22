import 'package:flutter/material.dart';
import 'package:parking/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    key,
    this.login = true, 
    required this.press,    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "No tienes una cuenta ? " : "Ya tienes una cuenta ? ",
          style: const TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Registrate" : "Logueate",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}