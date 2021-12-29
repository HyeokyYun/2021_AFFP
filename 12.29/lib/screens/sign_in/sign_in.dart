import 'package:cap_007_auth_noti/widgets/hero_image.dart';
import 'package:cap_007_auth_noti/widgets/hero_title.dart';
import 'package:flutter/material.dart';
import 'localWidgets/sign_in_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // shows header title
        HeroTitle(
          title: 'Welcome!',
          subtitle: 'Enter email and password to login...',
        ),
        // shows image
        HeroImage(
          path: 'assets/loginHero.svg',
          sementicLabel: 'Login Hero',
        ),
        // shows textfields and buttons
        SignInForm(),
      ],
    );
  }
}