import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cap_after_ds/theme/colors.dart';
import '../screens/root.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  var displayName = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  var googleAcc = Rx<GoogleSignInAccount?>(null);
  var isSignedIn = false.obs;

  User? get userProfile => auth.currentUser;
  User? currentUser;

  // token 추가
  String? _token;
  late FirebaseMessaging messaging;

  @override
  void onInit() {
    print("AUTH: ${isSignedIn}");
    // displayName = userProfile != null ? userProfile!.displayName! : '';
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      _token = value;
      print("token: $_token");
    });
    super.onInit();
  }

  void signUp(String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = name;
        auth.currentUser!.updateDisplayName(name);
      });

      //firestore에 저장
      var firebaseUser = FirebaseAuth.instance.currentUser;
      //.then((currentUser)  => FirebaseFirestore.instance
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser!.uid)
          .set({
        "name": name,
        "email": firebaseUser.email,
        "uid": firebaseUser.uid,
        "photoURL": firebaseUser.photoURL,
        "token": _token,
        "timeRegister": DateTime.now().millisecondsSinceEpoch.toString(),
        "ask": 0,
        "help": 0,
        "first time": false,
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .collection('thankLetter')
          .doc(firebaseUser.uid)
          .set({'thankLetter': FieldValue.arrayUnion([])});

      update();
      // print("token: $_token");

      //   await FirebaseFirestore.instance.collection('count').doc('counter').update({"count": FieldValue.increment(1)});
      Get.offAll(() => Root());
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => displayName = userProfile!.displayName!);
      isSignedIn.value = true;
      update();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userProfile!.uid)
          .update({'token': _token});
      print("token: $_token");
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
        'Error occurred!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    }
  }

  void signInWithGoogle() async {
    try {
      googleAcc.value = await _googleSignIn.signIn();

      // auth로 user data 입력
      GoogleSignInAccount? googleLogin = await _googleSignIn.signIn();

      GoogleSignInAuthentication? googleAuth =
          await googleLogin?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //firestore에 user 저장
      User? user = (await auth.signInWithCredential(credential)).user;
      if (user != null) {
        final QuerySnapshot addUser = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: user.uid)
            .get();

        final List<DocumentSnapshot> userList = addUser.docs;
        print(userList.isEmpty);
        if (userList.isEmpty) {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': user.displayName,
            'email': user.email,
            'uid': user.uid,
            'photoUrl': user.photoURL,
            'token': _token,
            'timeRegister': DateTime.now().millisecondsSinceEpoch.toString(),
            "ask": 0,
            "help": 0,
            "first time": false
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('thankLetter')
              .doc(user.uid)
              .set({'thankLetter': FieldValue.arrayUnion([])});

          currentUser = user;
        } else {
          FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'token': _token,
            'timeRegister': DateTime.now().millisecondsSinceEpoch.toString()
          });
          currentUser = user;
        }
      }
//디스플레이 이야기
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        displayName = documentSnapshot.get('name');
        isSignedIn.value = true; // <-- 로그인 완료 후, main으로 넘기기
        update(); // <-- without this the is Signedin value is not updated.
      });
      //  await FirebaseFirestore.instance.collection('count').doc('counter').update({"count": FieldValue.increment(1)});

    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void signInWithApple() async {
    try {
      //로그인 동작 수행
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      User? user = authResult.user;
      if (appleCredential.givenName != null) {
        user!.updateDisplayName(
            "${appleCredential.givenName} ${appleCredential.familyName}");
        displayName =
            "${appleCredential.givenName} ${appleCredential.familyName}";
      } else {
        user!.updateDisplayName("apple user");
        displayName = "apple user";
      }
      if (user != null) {
        final QuerySnapshot addUser = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .get();
        final List<DocumentSnapshot> userList = addUser.docs;
        if (userList.isEmpty) {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': appleCredential.givenName != null
                ? "${appleCredential.givenName} ${appleCredential.familyName}"
                : "apple user",
            'email': user.email,
            'uid': user.uid,
            'photoUrl': "",
            'token': _token,
            'timeRegister': DateTime.now().millisecondsSinceEpoch.toString(),
            "ask": 0,
            "help": 0,
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('thankLetter')
              .doc(user.uid)
              .set({'thankLetter': FieldValue.arrayUnion([])});
        } else {
          FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'token': _token,
            'timeRegister': DateTime.now().millisecondsSinceEpoch.toString()
          });
        }
        currentUser = user;
      }
      //디스플레이 이야기
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(currentUser!.uid)
      //     .get()
      //     .then((DocumentSnapshot documentSnapshot) {
      //   displayName = documentSnapshot.get('name');
      //   isSignedIn.value = true; // <-- 로그인 완료 후, main으로 넘기기
      //   update(); // <-- without this the is Signedin value is not updated.
      // });
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }

  void signout() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userProfile!.uid)
          .get()
          .then((DocumentSnapshot documentsnapshot) {
        if (documentsnapshot.exists != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userProfile!.uid)
              .update({'token': "sign out"});
        }
      });

      await auth.signOut();
      await _googleSignIn.signOut();

      // await FirebaseFirestore.instance.collection('users').doc(userProfile!.uid).update(
      //        {'token' : FieldValue.delete()});
      displayName = '';
      isSignedIn.value = false;
      update();
      Get.offAll(() => Root());
    } catch (e) {
      Get.snackbar('Error occurred!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white);
    }
  }
}

// to capitalize first letter of a Sting
extension StringExtension on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
