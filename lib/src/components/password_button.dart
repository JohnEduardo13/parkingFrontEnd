import 'package:flutter/material.dart';
import 'package:parking/constants.dart';
import 'package:parking/src/components/text_field_container.dart';

class PasswordButton extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textController;
  const PasswordButton({
    Key? key,
    required this.onChanged,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        controller: textController,
        onChanged: onChanged,
        validator: (value){
          if(value!.isEmpty){
            return 'Password is Empty';
          }
          return null;
        },
        cursorColor: kPrimaryColor,
        decoration: const InputDecoration(
          hintText: "Password",
          errorStyle: TextStyle(color: Colors.black),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}