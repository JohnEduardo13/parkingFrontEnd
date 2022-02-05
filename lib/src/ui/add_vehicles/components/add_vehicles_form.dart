import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/bottom_navigation_bar.dart';
import 'package:parking/src/components/button.dart';
import 'package:parking/src/models/vehicles_model.dart';
import 'package:parking/src/resources/vehicles_repository.dart';
import 'package:parking/src/ui/vehicles/components/vehicles_body.dart';

class VehiclesForm extends StatefulWidget {
  const VehiclesForm({Key? key}) : super(key: key);

  @override
  State<VehiclesForm> createState() => _VehiclesFormState();
}

class _VehiclesFormState extends State<VehiclesForm> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selecctedType;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    VehiclesRepository vehicleRepo = VehiclesRepository();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/parking_sin_fondo.png',
                  height: size.height * 0.35),
              SizedBox(height: size.height * 0.03),
              const Text(
                'Ingrese los datos para registrar su vehiculo',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: <Widget>[
                  const Text(
                    'Tipo de Vehiculo: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  selectType(),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: <Widget>[
                  const Text(
                    'Placa de Vehiculo: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 180,
                    height: 30,
                    child: textInput(),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.08),
              Row(
                children: <Widget>[
                  Button(
                    width: 0.35,
                    heigth: 0.07,
                    text: 'Salir',
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const BottomNavigation();
                        }),
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
                        vehicleRepo
                            .registerVehicle(VehiclesModel(
                                licensePlate:
                                    _textController.text.toUpperCase(),
                                typeVehicle: _selecctedType,
                                idDriver: 119421))
                            .then((response) {
                          if (response.statusCode == 200) {
                            clearText();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: kPrimaryLightColor,
                                    content: Text('Vehiculo Registrado',
                                        textAlign: TextAlign.center)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: kPrimaryLightColor,
                                    content: Text('Error al registrar vehiculo',
                                        textAlign: TextAlign.center)));
                          }
                        });
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textInput() {
    return TextFormField(
        controller: _textController,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'Ingrese su placa',
        ),
        validator: (value) => _validatorEmail(value!));
  }

  Widget selectType() {
    List<String> _types = ['Auto', 'Moto'];
    return DropdownButton<String>(
      hint: const Text('Ingrese el tipo de vehiculo'),
      value: _selecctedType,
      icon: const Icon(Icons.add),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (value) {
        setState(() {
          _selecctedType = value;
        });
      },
      items: _types.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void clearText() {
    _textController.clear();
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
