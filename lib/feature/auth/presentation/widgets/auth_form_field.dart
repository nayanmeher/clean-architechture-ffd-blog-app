import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isObscureText;
  const AuthFormField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.isObscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText
      ),
      validator: (val){
        if(val!.isEmpty){
          return "$hintText is missing" ;
        }
      },
      obscureText: isObscureText,
    );
  }
}
