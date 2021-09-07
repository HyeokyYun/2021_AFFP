import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wegolego_jjinjjin_0907/pages/login/login_controller.dart';

class HomePageController extends GetxController{
  final String title ="Home Page Title";

  var tabIndex=0;
  void changeTabIndex(int index){
    tabIndex = index;
    update();
  }

  // FirstPageController loginController = Get.find<FirstPageController>();
  LoginPageController loginController = Get.find<LoginPageController>();


  late User user;

  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    await loginController.googleSignIn.disconnect();
    await loginController.firebaseAuth.signOut();
  }

}