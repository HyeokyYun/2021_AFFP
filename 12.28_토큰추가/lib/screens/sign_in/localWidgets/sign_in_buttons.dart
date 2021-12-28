import 'package:cap_007_auth_noti/controllers/auth_controller.dart';
import 'package:cap_007_auth_noti/screens/reset_password/reset_password.dart';
import 'package:cap_007_auth_noti/screens/sign_up/sign_up.dart';
import 'package:cap_007_auth_noti/widgets/rounded_elevated_button.dart';
import 'package:cap_007_auth_noti/widgets/text_with_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import '../../../config.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();

    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(vertical: Config.screenHeight! * 0.005),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text('Forgot Password?'),
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
              horizontal: Config.screenWidth! * 0.4,
              vertical: Config.screenHeight! * 0.02,
            ),
          ),
          SizedBox(height: Config.screenHeight! * 0.01),
          SignInButton.mini(
            buttonType: ButtonType.google,
            onPressed: () => _authController.signInWithGoogle(),
          ),
          TextWithTextButton(
            text: 'Don\'t have an account?',
            textButtonText: 'Sign up',
            onPressed: () => Get.to(() => const SignUp()),
          ),
        ],
      ),
    );
  }
}