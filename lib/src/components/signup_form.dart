import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/bottom_navigation_bar.dart';
import 'package:parking/src/components/button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
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
          _addressInput(),
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
        decoration: const InputDecoration(
          hintText: 'Inserte su nombre',
          labelText: 'Nombre',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _lastNameInput() {
    return TextFormField(
        decoration: const InputDecoration(
          hintText: 'Inserte su apellido',
          labelText: 'Apellido',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _documentInput() {
    return TextFormField(
        decoration: const InputDecoration(
          hintText: 'Inserte su documento',
          labelText: 'Documento',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _addressInput() {
    return TextFormField(
        decoration: const InputDecoration(
          hintText: 'Inserte su direccion',
          labelText: 'Direccion',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _phoneInput() {
    return TextFormField(
        decoration: const InputDecoration(
          hintText: 'Inserte su telefono',
          labelText: 'Telefono',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget _emailInput() {
    return TextFormField(
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
        decoration: const InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Inserte su contraseña',
          labelText: 'Contraseña',
        ),
        validator: (value) => _validatorPassword(value!));
  }

  Widget _loginButton() {
    return Button(
      text: loginButton,
      press: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login correcto')));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const BottomNavigation();
            }),
          );
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
    return value.isNotEmpty && value.length >= 8;
  }
}
