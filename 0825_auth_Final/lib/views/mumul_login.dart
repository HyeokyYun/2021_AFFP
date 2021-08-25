import 'package:auth_final_0824/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_view.dart';
import 'mumul_signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MumulLogin extends StatefulWidget {
  const MumulLogin({Key? key}) : super(key:key);
  @override
  _MumulLoginState createState() => _MumulLoginState();
}

class _MumulLoginState extends State<MumulLogin> {
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool _obscuretext = true;

  @override
  initState() {
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
            backgroundColor: Colors.white,
            leading: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
            }, icon:  Icon(Icons.arrow_back), color: Colors.black)
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
                      height:(30)
                  ),
                  Text('이메일'),
                  TextFormField(
                    validator:  (val)=> val!.length < 1 ? '이메일을입력하세요. ' : null,
                    decoration: InputDecoration(
                      hintText: 'wegolego@mumul.com',
                      hintStyle: TextStyle(
                          color: Color(0XFF7EA68D)
                      ),),
                    controller: emailController,
                  ),
                  SizedBox (
                      height: (30)
                  ),
                  Text('비밀번호'),
                  TextFormField(
                    validator: (val)=> val!.length < 8 ? '비. ' : null,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                SignupView()));
                          },
                          splashColor: Colors.grey.withOpacity(0.5),
                          child: Text(
                            "회원가입",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.deepPurpleAccent
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: (80),),

                  Center(
                    child: SizedBox(
                      height: (50),
                      width: (280),

                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0XFF7EA68D),
                          ),
                          child: Text('로그인'),
                          onPressed
                              :() async {
                            if (_key.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                                //await Fluttertoast.showToast(msg: "Mumul Sign In");

                              } on FirebaseAuthException catch (error) {
                                //await Fluttertoast.showToast(msg: "Error: Mumul Sign In");
                                // errorMessage = error.message!;
                              }
                              var fbUser= FirebaseAuth.instance.currentUser;
                              print(fbUser!.email);
                              if(fbUser != null){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                    HomeScreen()));
                              }
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

}
