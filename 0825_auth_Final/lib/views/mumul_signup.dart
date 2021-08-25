import 'package:auth_final_0824/views/mumul_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key:key);
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool _obscuretext = true;

  bool isCorrect  = true;

  @override
  initState() {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MumulLogin()));
            }, icon:  Icon(Icons.arrow_back))
        ),
        body:
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              // padding: EdgeInsets.all(48),
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox (
                      height: 50
                  ),
                  Text('사용자 이름',),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '홍길동',
                      hintStyle: TextStyle(
                          color: Color(0XFF7EA68D)
                      ),),
                    controller: nameController,
                    validator: (val) => val!.length < 1 ? '이름을 입력하세요. ' : null,
                  ),
                  SizedBox (
                      height:(30)
                  ),
                  Text('이메일'),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'wegolego@mumul.com',
                      hintStyle: TextStyle(
                          color: Color(0XFF7EA68D)
                      ),),
                    controller: emailController,
                    validator: (val)=> val!.length < 1 ? '이메일을입력하세요. ' : null,
                  ),
                  SizedBox (
                      height: (30)
                  ),
                  Text('비밀번호'),
                  TextFormField(
                    obscureText: _obscuretext,
                    decoration: InputDecoration(
                      hintText: '8자리 이상',
                      hintStyle: TextStyle(
                          color: Color(0XFF7EA68D)
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                        ),
                        onPressed: (){
                          setState(() {
                            _obscuretext = !_obscuretext;
                          });
                          // _controller.obscureChange;
                        },
                      ),
                    ),
                    controller: passwordController,
                    validator:
                        (val)=> val!.length < 8 ? '8자리 이상 입력하세요. ' : null,
                  ),

                  SizedBox(height: (127),),

                  Center(
                    child: SizedBox(
                      height: (50),
                      width: (280),

                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0XFF7EA68D),
                          ),
                          child: Text('회원가입'),
                          onPressed :() async {
                            if (_key.currentState!.validate()) {
                              try {
                                dynamic result = await
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                var firebaseUser= FirebaseAuth.instance.currentUser;
                                //.then((currentUser)  => FirebaseFirestore.instance
                                FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid).set(
                                    {
                                      "name": nameController.text,
                                      "email": firebaseUser.email,
                                      "uid" :  firebaseUser.uid,
                                      "photoURL" : firebaseUser.photoURL,
                                      "time" : DateTime.now().millisecondsSinceEpoch.toString(),
                                    }
                                );
                                //await Fluttertoast.showToast(msg: "Mumul Log In success");
                              } on FirebaseAuthException catch (error) {
                                //await Fluttertoast.showToast(msg: "Mumul Sign Up Error");
                                // errorMessage = error.message!;
                              }

                              if(_key.currentState!.validate()) Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  SignInPage()));
                            }
                          }

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
