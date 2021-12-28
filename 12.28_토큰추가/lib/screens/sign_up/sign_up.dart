import 'package:cap_007_auth_noti/screens/sign_up/sign_up_buttons.dart';
import 'package:cap_007_auth_noti/widgets/hero_title.dart';
import 'package:cap_007_auth_noti/widgets/rounded_text_formfield.dart';
import 'package:flutter/material.dart';
import '../../config.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Config.screenWidth! * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const HeroTitle(
                  title: 'Sign Up',
                  subtitle: 'Create an account...',
                ),
                buildTextFormFields(),
                SignUpButtons(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildTextFormFields() {
    return Expanded(
      flex: 8,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(height: Config.screenHeight! * 0.08),
          ),
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
      ),
    );
  }
}