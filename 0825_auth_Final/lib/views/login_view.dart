import 'package:auth_final_0824/Widgets/loading.dart';
import 'package:auth_final_0824/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'mumul_login.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences? prefs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isLoggedIn = false;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn && prefs?.getString('id') != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }

    this.setState(() {
      isLoading = false;
    });
  }

  Future<void> handleGoogleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    GoogleSignInAccount? googleLogin = await googleSignIn.signIn();
    if (googleLogin != null) {
      GoogleSignInAuthentication? googleAuth = await googleLogin.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User? googleUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (googleUser != null) {
        final QuerySnapshot addUser = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: googleUser.uid)
            .get();
        final List<DocumentSnapshot> userList = addUser.docs;
        if (userList.length == 0) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(googleUser.uid)
              .set({
            'userName': googleUser.displayName,
            'photoUrl': googleUser.photoURL,
            'uid': googleUser.uid,
            'email': googleUser.email,
            'timeRegister': DateTime.now().millisecondsSinceEpoch.toString()
          });
          currentUser = googleUser;
          await prefs?.setString('uid', currentUser!.uid);
          await prefs?.setString('userName', currentUser!.displayName ?? "");
          await prefs?.setString('photoUrl', currentUser!.photoURL ?? "");
        }
        Fluttertoast.showToast(msg: "Sign in success");
        this.setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Fluttertoast.showToast(msg: "Error: Google Sign In");
        this.setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List steps = [_step1(), _step2(), _step3(), _step4()];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(
                color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints.expand(height: 200),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return steps[index];
                    },
                    loop: false,
                    autoplay: true,
                    itemCount: steps.length,
                    viewportFraction: 0.8,
                    scale: 0.9,

                    pagination: new SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: new DotSwiperPaginationBuilder(
                          color: Colors.grey[200],
                          activeColor: Color(0XFF7EA68D)),
                    ),
                    //control: new SwiperController(),
                  ),
                ),
                InkWell(
                  onTap: () => handleGoogleSignIn().catchError((err){
                    print(err);
                    this.setState(() {
                      isLoading=false;
                    });
                  }),
                  splashColor: Colors.grey.withOpacity(0.5),
                  child: Ink(
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/google_login.jpeg'),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 376),
                    //context.width),
                    child: TextButton(
                      child: Text(
                        "다른방법으로 로그인 ",
                        style: TextStyle(fontSize: ScreenUtil().setSp(16), color: Colors.grey,decoration: TextDecoration.underline,),
                      ),
                      onPressed: () {
                        //Get.to(AuthApp());
                        Dialogs.bottomMaterialDialog(
                          //msg:'다른방법으로 로그인 ',
                            context: context,
                            actions: [
                              Column(
                                  children:[
                                    /*
                                      Transform.scale(
                                        scale: 9.0,
                                        child: IconButton(
                                          icon: Image.asset('images/facebook_login.jpeg',),
                                          onPressed: (){
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Transform.scale(
                                        scale: 9.0,
                                        child: IconButton(
                                          icon: Image.asset('images/naver_login.jpeg',),
                                          onPressed: (){
                                          },
                                        ),
                                      ),*/
                                    //SizedBox(height: 10,),
                                    Transform.scale(
                                      scale: 9.0,
                                      child: IconButton(
                                        icon: Image.asset('images/mumul_login.jpeg',),
                                        onPressed:(){Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => MumulLogin()));} ,

                                      ),
                                    ),
                                  ]
                              )
                            ]
                        );
                      },
                    ),
                  ),
                ),
                // IconButton(
                //     onPressed: () => handleGoogleSignIn().catchError((err) {
                //           print("$err");
                //           //Fluttertoast.showToast(msg: err.toString());
                //           this.setState(() {
                //             isLoading = false;
                //           });
                //         }),
                //     icon: Image.asset('images/google_login.jpeg')),
                // TextButton(
                //   onPressed: () => handleGoogleSignIn().catchError((err) {
                //     print("$err");
                //     //Fluttertoast.showToast(msg: err.toString());
                //     this.setState(() {
                //       isLoading = false;
                //     });
                //   }),
                //   child: Text(
                //     'SIGN IN WITH GOOGLE',
                //     style: TextStyle(fontSize: 16.0, color: Colors.white),
                //   ),
                //   style: ButtonStyle(
                //       backgroundColor:
                //           MaterialStateProperty.all<Color>(Color(0xffdd4b39)),
                //       padding: MaterialStateProperty.all<EdgeInsets>(
                //           EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0))),
                // ),
                // Loading
              ],
            ),
          ),
        ));
  }

  Widget _step1() {
    return Container(
        child: Column(children: [
      Image.asset(
        'images/mumul_logo.png',
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(67),
      ),
      SizedBox(height: ScreenUtil().setHeight(26)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '무',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
        ),
        Text('엇이든 ', style: TextStyle(fontSize: ScreenUtil().setSp(28))),
        Text('물',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D))),
        Text('어보세요!', style: TextStyle(fontSize: ScreenUtil().setSp(28))),
      ]),
      Text('''
어디서든 무엇이든
모두가 도움을 주고받을수 있는 ''',
          maxLines: 20,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil().setSp(14))),
    ]));
  }

  Widget _step2() {
    return Container(
        child: Column(children: [
      Image.asset(
        'images/step1.png',
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(67),
      ),
      SizedBox(height: ScreenUtil().setHeight(26)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '''  누구에게나
자유로운 질문''',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
        ),
      ]),
    ]));
  }

  Widget _step3() {
    return Container(
        child: Center(
      child: Column(children: [
        Image.asset(
          'images/step2.png',
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(67),
        ),
        SizedBox(height: ScreenUtil().setHeight(26)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '''다양한 카테고리의 질문''',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
          ),
        ]),
      ]),
    ));
  }

  Widget _step4() {
    return Container(
        child: Center(
      child: Column(children: [
        Image.asset(
          'images/mumul_logo.png',
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(67),
        ),
        SizedBox(height: ScreenUtil().setHeight(26)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            '''      지금 가입하고
 도움을 나누어 보세요 ''',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
          ),
        ]),
      ]),
    ));
  }
}