import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/already_have_an_account_check.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/components/input_button.dart';
import 'package:parking/src/components/password_button.dart';
import 'package:parking/src/models/user_model.dart';
import 'package:parking/src/resources/user_repository.dart';
import 'package:parking/src/services/login_state.dart';
import 'package:provider/provider.dart';

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
            const Padding(
              padding: EdgeInsets.fromLTRB(35, 50, 35, 15),
              child: Text(
                loginTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset('assets/images/logo_sin_fondo.png',
                height: size.height * 0.4),
            SizedBox(height: size.height * 0.03),
            InputButton(
              textController: _userController,
              hintText: "Your Email",
              onChanged: (value) {
                user.user = value;
              },
            ),
            PasswordButton(
              textController: _passController,
              onChanged: (value) {
                user.password = value;
              },
            ),
            Button(
              width: 0.8,
              heigth: 0.07,
              text: loginButton,
              press: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const BottomNavigation();
                  }),
                );*/
                if (_formKey.currentState!.validate()) {
                  userRepo.searchUser(_userController.text).then((response) {
                    if (response.statusCode == 200) {
                      userRepo
                          .searchUserData(_userController.text)
                          .then((response) {
                        if (response.user == _userController.text &&
                            response.password == _passController.text) {
                          Provider.of<LoginState>(context, listen: false).login(
                              _userController.text, _passController.text);
                          Navigator.of(context).pushReplacementNamed('/home');
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const BottomNavigation();
                            }),
                          );*/
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: kPrimaryLightColor,
                                  content: Text('Datos Incorrectos',
                                      textAlign: TextAlign.center)));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: kPrimaryLightColor,
                          content: Text('El usuario no se encuentra registrado',
                              textAlign: TextAlign.center)));
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: kPrimaryLightColor,
                      content: Text('Porfavor llene todos los campos',
                          textAlign: TextAlign.center)));
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.of(context).pushNamed('/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
