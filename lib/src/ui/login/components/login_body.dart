import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/already_have_an_account_check.dart';
import 'package:parking/src/components/bottom_navigation_bar.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/components/input_button.dart';
import 'package:parking/src/components/password_button.dart';
import 'package:parking/src/ui/login/components/login_background.dart';
import 'package:parking/src/ui/signup/signup_screen.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              loginTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              'assets/images/parking.png',
              height: size.height * 0.45
            ),
            SizedBox(height: size.height * 0.03),
            InputButton(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            PasswordButton(
              onChanged: (value) {},
            ),
            Button(
              text: loginButton,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return const BottomNavigation();
                    }
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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