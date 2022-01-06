import 'package:wegolego_v014/widgets/hero_image.dart';
import 'package:wegolego_v014/widgets/hero_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config.dart';
import 'localWidgets/reset_form.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Config.screenWidth! * 0.04),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ),
                const HeroTitle(
                    title: 'Recovery', subtitle: 'Please enter you account email'),
                SizedBox(height: Config.screenHeight! * 0.05),
                const HeroImage(
                    path: 'assets/resetHero.svg', sementicLabel: 'Reset Hero'),
                SizedBox(height: Config.screenHeight! * 0.05),
                const ResetForm(),
                SizedBox(height: Config.screenHeight! * 0.2),
              ],
            ),
          )),
    );
  }
}