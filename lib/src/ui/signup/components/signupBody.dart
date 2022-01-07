import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parking/src/components/alreadyHaveAnAccountCheck.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/components/inputButton.dart';
import 'package:parking/src/components/passwordButton.dart';
import 'package:parking/src/ui/login/loginScreen.dart';
import 'package:parking/src/ui/signup/components/signupBackground.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SignupBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            InputButton(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            PasswordButton(
              onChanged: (value) {},
            ),
            Button(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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
          ],
        ),
      ),
    );
  }
}