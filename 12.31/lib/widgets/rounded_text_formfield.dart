import 'package:flutter/material.dart';

import '../config.dart';

class RoundedTextFormField extends StatelessWidget {
  const RoundedTextFormField({
    Key? key,
    this.controller,
    this.obsecureText = false,
    @required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? obsecureText;
  final String? hintText;
  final validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText!,
      decoration: InputDecoration(
        hintText: hintText!,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
        enabledBorder:OutlineInputBorder(
          borderSide: BorderSide(color:Colors.green),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderSide:  BorderSide(color:Colors.green),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
      ),
      validator: validator,
    );
  }
}