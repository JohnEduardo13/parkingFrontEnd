import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/already_have_an_account_check.dart';
import 'package:parking/src/components/signup_form.dart';
import 'package:parking/src/ui/login/login_screen.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(35, 50, 35, 15),
            child: Text(
              signUpTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset('assets/images/perfil_2.png',
                height: size.height * 0.15),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(35, 15, 35, 10),
            child: SignupForm(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 5, 35, 20),
            child: AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
