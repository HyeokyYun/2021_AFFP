import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notifi_0817_2/model/user_chat.dart';
import 'package:flutter_notifi_0817_2/utils/const.dart';
import 'package:flutter_notifi_0817_2/widget/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn(); // 구글 로그인을 위해 선언해줌.
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance; // Firebase Auth를 위한 선언 및 instance 설정.

  // key-value 형태의 데이터를 디스크에 저장해서 사용하는 방법.
  // 로그인이 필요한 앱에서 사용자의 ID와 비밀번호 등을 기억하는 기능을 구현할 때 사용.
  SharedPreferences? prefs;

  bool isLoading = false; // 페이지 이동에서 로딩할 때 사용.
  bool isLoggedIn = false; // 로그인 되어 있는지 아닌지 확인.
  User? currentUser; // FirebaseAuth에서 user를 파악할 때 사용.

  @override
  void initState(){
    super.initState();
    isSignedIn(); // 먼저 로그인이 되어 있는지 확인을 위해 되어 있으면 함수 실행.
  }

  void isSignedIn() async { // async를 통해 순차적 실행.
    this.setState(() {
      // 만약 로그인이 되어 있으면 isLoading 이 true 로 되고 로딩화면을 보여줌.
      isLoading = true;
    });

    // prefs 는 key-value 가 저장되어 있음. 그래서 로그인 정보를 디스크에서 가져옴.
    prefs = await SharedPreferences.getInstance();

    // isLoggedIn은 googleSignIn이 isSignedIn을 통해 로그인 되어 있는지 확인.
    // 로그인 되어 있으면 true로 바뀜.
    isLoggedIn = await googleSignIn.isSignedIn();

    // isLoggedIn과 prefs에 값이 있으면,
    // HomeScreen()으로 자동으로 넘어감. 여기서 HomeScreen에서 true면 사용자의 id를, 아니면 "" 값을 불러옴.
    if(isLoggedIn && prefs?.getString('id') != null){
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomeScreen(currentUserId: prefs!.getString('id') ?? "")),
      );
    }

    // 위 과정이 완료되면 로딩 종료.
    this.setState(() {
      isLoading = false;
    });
  }

  // Google Login 관리.
  Future<void> handleSignIn() async {
    // prefs에 관련 정보 저장.
    prefs = await SharedPreferences.getInstance();

    // 로딩중으로 변경.
    this.setState(() {
      isLoading = true;
    });

    // 구글 로그인 과정..?
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser != null){
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // Auth 검증.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase에서 user 관리를 위한 사용.
      User? firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null){
        // Check is already sign up

        // FirebaseFirestore에 저장된 id 정보와 같으면,
        final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).get();
        // result.docs의 정보들을 리스트로 저장.
        final List<DocumentSnapshot> documents = result.docs;

        if(documents.length == 0){
          // Update data to server if new user 새 유저 정보 등록.
          FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set({
            'nickname': firebaseUser.displayName,
            'photoUrl': firebaseUser.photoURL,
            'id': firebaseUser.uid,
            'createAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          });

          // Write data to firestore 데이터 파이어스토어에 저장.
          currentUser = firebaseUser; // 현재 유저는 파이어베이스 유저의 유저.
          await prefs?.setString('id', currentUser!.uid);
          await prefs?.setString('nickname', currentUser!.displayName ?? "");
          await prefs?.setString('photoUrl', currentUser!.photoURL ?? "");
        } else {
          DocumentSnapshot documentSnapshot = documents[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);

          // Write data to local 데이터 로컬에 저장.
          await prefs?.setString('id', userChat.id);
          await prefs?.setString('nickname', userChat.nickname);
          await prefs?.setString('photoUrl', userChat.photoUrl);
          await prefs?.setString('aboutMe', userChat.aboutMe);
        }
        Fluttertoast.showToast(msg: 'Sign in success');
        this.setState(() {
          isLoading = false;
        });

        // 로그인 하면 홈 화면으로 넘어감.
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(currentUserId: firebaseUser.uid,)));
      } else {
        Fluttertoast.showToast(msg: "Sign in fail");
        this.setState(() {
          isLoading = false;
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Can not init google sign in");
      this.setState(() {
        isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: TextButton(
                onPressed: () => handleSignIn().catchError((err) {
                  Fluttertoast.showToast(msg: err.toString());
                  this.setState(() {
                    isLoading = false;
                  });
                }),
                child: Text(
                  'SIGN IN WITH GOOGLE',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffdd4b39)),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0))),
              ),
            ),
            // Loading
            Positioned(
              child: isLoading ? const Loading() : Container(),
            ),
          ],
        ));
  }
}
