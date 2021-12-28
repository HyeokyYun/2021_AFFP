import 'package:cap_007_auth_noti/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(child: GetBuilder<AuthController>(
        builder: (_authController) {
          return Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Hello ${_authController.displayName.toString().capitalizeString()}!'),
              ElevatedButton(
                child: const Text('Sign out') ,
                onPressed: () => _authController.signout(),
              ),
            ],
          ));
        },
      )),
    );
  }
}