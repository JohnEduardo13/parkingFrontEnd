import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/already_have_an_account_check.dart';
import 'package:parking/src/components/bottom_navigation_bar.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/components/input_button.dart';
import 'package:parking/src/components/password_button.dart';
import 'package:parking/src/models/user_model.dart';
import 'package:parking/src/resources/user_repository.dart';
import 'package:parking/src/ui/login/components/login_background.dart';
import 'package:parking/src/ui/signup/signup_screen.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _userController = TextEditingController();
    final _passController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    UserRepository userRepo = UserRepository();
    UserModel user = UserModel();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              loginTitle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset('assets/images/parking.png',
                height: size.height * 0.45),
            SizedBox(height: size.height * 0.03),
            InputButton(
              textController: _userController,
              hintText: "Your Email",
              onChanged: (value) {
                user.user = value;
              },
              /*validator: (value){
                if(value!.isEmpty){
                  return 'Email is Empty';
                }
                return '';
              },*/
            ),
            PasswordButton(
              textController: _passController,
              onChanged: (value) {
                user.password = value;
              },
              /*validator: (value){
                if(value!.isEmpty){
                  return 'Password is Empty';
                }
                return '';
              },*/
            ),
            Button(
              width: 0.8,
              heigth: 0.07,
              text: loginButton,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const BottomNavigation();
                  }),
                );
                /*if (_formKey.currentState!.validate()) {
                  userRepo.searchUser(_userController.text).then((response) {
                    if (response.statusCode == 200) {
                      userRepo
                          .searchUserData(_userController.text)
                          .then((response) {
                        if (response.user == _userController.text &&
                            response.password == _passController.text) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const BottomNavigation();
                            }),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Datos Incorrectos')));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'El usuario no se encuentra registrado')));
                    }
                  });
                } else {
                  print("sin datos");
                }*/
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
