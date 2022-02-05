import 'package:flutter/material.dart';
import 'package:parking/src/ui/signup/components/signup_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignupBody(),
    );
  }
}