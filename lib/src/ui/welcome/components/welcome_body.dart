import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/services/login_state.dart';
import 'package:provider/provider.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //bool state = Provider.of<LoginState>(context, listen: false).isLoggedIn();
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
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
            Button(
              width: 0.8,
              heigth: 0.07,
              text: singUpButton,
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
