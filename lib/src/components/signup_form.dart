import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/bottom_navigation_bar.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/models/driver_model.dart';
import 'package:parking/src/models/user_model.dart';
import 'package:parking/src/resources/driver_repository.dart';
import 'package:parking/src/resources/user_repository.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  UserModel userModel = UserModel();
  UserRepository userRepo = UserRepository();
  DriverRepository driverRepo = DriverRepository();

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _documentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _nameInput(),
          _lastNameInput(),
          _documentInput(),
          _phoneInput(),
          _emailInput(),
          _passwordInput(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _loginButton()),
        ],
      ),
    );
  }

  Widget _nameInput() {
    return TextFormField(
        controller: _nameController,
        decoration: const InputDecoration(
          hintText: 'Inserte su nombre',
          labelText: 'Nombre',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _lastNameInput() {
    return TextFormField(
        controller: _lastNameController,
        decoration: const InputDecoration(
          hintText: 'Inserte su apellido',
          labelText: 'Apellido',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _documentInput() {
    return TextFormField(
        controller: _documentController,
        decoration: const InputDecoration(
          hintText: 'Inserte su documento',
          labelText: 'Documento',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _phoneInput() {
    return TextFormField(
        controller: _phoneController,
        decoration: const InputDecoration(
          hintText: 'Inserte su telefono',
          labelText: 'Telefono',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _emailInput() {
    return TextFormField(
        controller: _userController,
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Inserte su email',
          labelText: 'Email',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _passwordInput() {
    return TextFormField(
        obscureText: true,
        controller: _passController,
        decoration: const InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Inserte su contraseña',
          labelText: 'Contraseña',
        ),
        validator: (value) => _validatorPassword(value!));
  }

  Widget _loginButton() {
    bool save = false;
    return Button(
      width: 0.8,
      heigth: 0.07,
      text: loginButton,
      press: () {
        save = false;
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          userRepo.searchUser(_userController.text).then((response1) {
            if (response1.statusCode == 200) {
              print(response1.statusCode);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('El usuario ya se encuentra registrado')));
            } else {
              if (response1.statusCode == 204) {
                print("USUARIO NO ENCONTRADO");
                userRepo
                    .registerUSer(UserModel(
                        user: _userController.text,
                        password: _passController.text))
                    .then((response2) {
                  if (response2.statusCode == 200) {
                    driverRepo
                        .registerDriver(DriverModel(
                            document: int.parse(_documentController.text),
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            email: _userController.text,
                            phone: _phoneController.text))
                        .then((response3) {
                      print(response3.statusCode);
                      if (response3.statusCode == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Usuario Creado')));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const BottomNavigation();
                          }),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Error al no poder crear el usuario')));
                      }
                    }).catchError((Object error) {
                      print(' Error ${error}');
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuario Creado')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Error al crear el usuario')));
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Error al consultar el usuario')));
              }
            }
          });
        }
      },
    );
  }

  String? _validatorEmail(String value) {
    if (!_hasMinLenght(value)) {
      return 'Please enter some text';
    }
  }

  String? _validatorPassword(String value) {
    if (!_hasMinLenght(value)) {
      return 'Please enter some text';
    }
  }

  bool _isEmail(String str) {
    return _emailRegExp.hasMatch(str.toLowerCase());
  }

  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

  bool _hasMinLenght(String value) {
    return value.isNotEmpty && value.length >= 3;
  }
}
