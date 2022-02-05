import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/ui/login/login_screen.dart';
import 'package:parking/src/ui/signup/signup_screen.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              welcomeTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset('assets/images/logo_sin_fondo.png',
                height: size.height * 0.4),
            SizedBox(height: size.height * 0.03),
            Button(
              width: 0.8,
              heigth: 0.07,
              text: loginButton,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            Button(
              width: 0.8,
              heigth: 0.07,
              text: singUpButton,
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
