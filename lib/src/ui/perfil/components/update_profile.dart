import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/models/driver_model.dart';
import 'package:parking/src/resources/driver_repository.dart';
import 'package:parking/src/services/login_state.dart';
import 'package:parking/src/ui/perfil/perfil_screen.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? idUser;
  String? email;
  DriverRepository driver = DriverRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    idUser = Provider.of<LoginState>(context, listen: false).currentIdUser();
    email = Provider.of<LoginState>(context, listen: false).currentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Mi Datos"),
      ),
      body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.fromLTRB(35, 40, 35, 20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/perfil_2.png',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                'Ingrese los datos para actualizar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 35, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text(
                          'Nombre: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: textInput('Ingrese su nombre', _nameController),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 35, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text(
                          'Apellido: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: textInput(
                              'Ingrese su apellido', _lastNameController),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 35, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Text(
                          'Telefono: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 200,
                          height: 30,
                          child:
                              textInput('Ingrese su telefono', _mobileController),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 15, 35, 10),
                child: Row(
                  children: <Widget>[
                    Button(
                      width: 0.35,
                      heigth: 0.07,
                      text: 'Salir',
                      press: () {
                        //Navigator.of(context).pushReplacementNamed('/home');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PerfilScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: size.height * 0.05),
                    Button(
                      width: 0.35,
                      heigth: 0.07,
                      text: 'Guardar',
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          driver
                              .updateDriver(DriverModel(
                            document: idUser,
                            name: _nameController.text,
                            lastName: _lastNameController.text,
                            email: email,
                            phone: _mobileController.text,
                          ))
                              .then((response) {
                            if (response.statusCode == 200) {
                              clearText();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: kPrimaryLightColor,
                                      content: Text('Datos actualizados',
                                          textAlign: TextAlign.center)));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: kPrimaryLightColor,
                                        content: Text('Error al actualizar datos',
                                            textAlign: TextAlign.center)));
                            }
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textInput(String info, TextEditingController textController) {
    return TextFormField(
        controller: textController,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: info,
        ),
        validator: (value) => _validatorEmail(value!));
  }

  void clearText() {
    _nameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _mobileController.clear();
  }

  String? _validatorEmail(String value) {
    if (!_hasMinLenght(value)) {
      return 'Valide los datos';
    }
  }

  bool _hasMinLenght(String value) {
    return value.isNotEmpty && value.length >= 3;
  }
}
