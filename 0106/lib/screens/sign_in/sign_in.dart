import 'package:wegolego_v014/controllers/auth_controller.dart';
import 'package:wegolego_v014/screens/reset_password/reset_password.dart';
import 'package:wegolego_v014/screens/sign_up/sign_up.dart';
import 'package:wegolego_v014/widgets/rounded_elevated_button.dart';
import 'package:wegolego_v014/widgets/rounded_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import '../../config.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    return Center(
      child: SizedBox(
        width: Config.screenWidth! * 0.9,
        height: Config.screenHeight! * 1.5,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: Config.screenHeight! * 0.08),
                  Text("Log In",style: TextStyle(fontSize: Config.screenWidth! * 0.08),),
                  SizedBox(height: Config.screenHeight! * 0.05),
                  buildTextFormFields(),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: Config.screenHeight! * 0.005),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: const Text('Forgot Password?',style: TextStyle(color:Color(0xff688C76))),
                        onPressed: () => Get.to(() => const ResetPassword()),
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  RoundedElevatedButton(
                    title: 'Sign in',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text.trim();
                        String password = _passwordController.text;

                        _authController.signIn(email, password);
                      }
                    },
                    padding: EdgeInsets.symmetric(
                      horizontal: Config.screenWidth! * 0.3,
                      vertical: Config.screenHeight! * 0.02,
                    ),
                  ),
                  SizedBox(height: Config.screenHeight! * 0.01),
                  SignInButton.mini(
                    buttonType: ButtonType.google,
                    onPressed: () => _authController.signInWithGoogle(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ const Text(
                        ' Don\'t have an account?'
                    ),TextButton(
                      child: const Text('Sign up' ,style: TextStyle(color:Color(0xff688C76)),),

                      onPressed: () => Get.offAll(() => const SignUp()),
                    ),],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
  Widget buildTextFormFields() {
    return Column(
      children: [
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
        SizedBox(height: Config.screenHeight! * 0.01),
        RoundedTextFormField(
          controller: _passwordController,
          hintText: 'Password',
          obsecureText: true,
          validator: (value) {
            if (value.toString().length < 6) {
              return 'Password should be longer or equal to 6 characters.';
            }
            return null;
          },
        ),
      ],
    );
  }
}