import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parking/src/components/alreadyHaveAnAccountCheck.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/components/inputButton.dart';
import 'package:parking/src/components/passwordButton.dart';
import 'package:parking/src/ui/login/components/loginBackground.dart';
import 'package:parking/src/ui/signup/signupScreen.dart';

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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
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
              text: "LOGIN",
              press: () {},
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