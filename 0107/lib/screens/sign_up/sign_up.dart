import 'package:wegolego_v014/controllers/auth_controller.dart';
import 'package:wegolego_v014/widgets/rounded_elevated_button.dart';
import 'package:wegolego_v014/widgets/rounded_text_formfield.dart';
import 'package:flutter/material.dart';
import '../../config.dart';
import 'package:get/get.dart';

import '../root.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Sign Up',
      //     textAlign: TextAlign.center,
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Config.screenWidth! * 0.04),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Config.screenHeight! * 0.08),
                  Text("Sign Up",style: TextStyle(fontSize: Config.screenWidth! * 0.08),),
                  SizedBox(height: Config.screenHeight! * 0.05),
                  buildTextFormFields(),
                  SizedBox(height: Config.screenHeight! * 0.05),
                  RoundedElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String name = _nameController.text.trim();
                        String email = _emailController.text.trim();
                        String password = _passwordController.text;
                        _authController.signUp(name, email, password);
                      }
                    },
                    title: 'Sign up',
                    padding: EdgeInsets.symmetric(
                      horizontal: Config.screenWidth! * 0.38,
                      vertical: Config.screenHeight! * 0.02,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?'
                    ),TextButton(
                      child: Text('Sign in' ,style: TextStyle(color:Color(0xff688C76)),),

                      onPressed: () => Get.offAll(() => Root()),
                    ),],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFields() {
    return Column(
      children: [
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          controller: _nameController,
          hintText: 'Name',
          validator: (value) {
            if (value.toString().length <= 2) {
              return 'Enter valid name.';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          controller: _emailController,
          hintText: 'Email',
          validator: (value) {
            bool _isEmailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!);
            if (!_isEmailValid) {
              return 'Invalid email.';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          controller: _passwordController,
          obsecureText: true,
          hintText: 'Password',
          validator: (value) {
            if (value.toString().length < 6) {
              return 'Password should be longer or equal to 6 characters.';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.02),
        RoundedTextFormField(
          obsecureText: true,
          hintText: 'Confirm Password',
          validator: (value) {
            if (value.trim() != _passwordController.text.trim()) {
              return 'Passwords does not match!';
            }

            return null;
          },
        ),
      ],
    );
  }
}