import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/text_field_container.dart';

class InputButton extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  final ValueChanged<String> onChanged;
  const InputButton({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: textController,
        onChanged: onChanged,
        validator: (value){
          if(value!.isEmpty){
            return 'Ingrese su email';
          }
          return null;
        },
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: Colors.white),
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}