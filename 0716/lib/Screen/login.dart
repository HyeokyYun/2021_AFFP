import 'package:des_dev_camp2021/Widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "로그인",
        automaticallyImplyLeading: false,
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox (
                  height: 70.0
              ),
              Text('ID'),
              SizedBox (
                  height: 10.0
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '아이디를 입력해주세요',
                  hintStyle: TextStyle(
                      color: Colors.green[200]
                  ),
                ),
              ),
              SizedBox (
                  height: 20.0
              ),
              Text('PW'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '비밀번호를 입력해주세요',
                  hintStyle: TextStyle(
                    color: Colors.green[200]
                  ),
                ),
              ),
              SizedBox (
                  height: 20.0
              ),
              Center(
                child: ElevatedButton(
                    onPressed:(){
                      Get.toNamed('/extra_info');
                    } ,
                    child: Text(
                        '로그인'
                    )
                ),
              ),
              Container(
                width: double.infinity,
                child:TextButton(
                  onPressed: (){
                    Get.toNamed('/sign_up');
                  },
                  child: Text('회원이 아니신가요?',
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              SizedBox (
                  height: 20.0
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 36, right: 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SignInButton(
                        Buttons.Facebook,
                        mini: true,
                        onPressed:(){
                        },
                      ),
                      SignInButton(
                        Buttons.GitHub,
                        mini: true,
                        onPressed:(){
                        },
                      ),SignInButton(
                        Buttons.Apple,
                        mini: true,
                        onPressed:(){
                        },
                      ),
                      SignInButton(
                        Buttons.Twitter,
                        mini: true,
                        onPressed:(){
                        },
                      ),
                    ],
                  ),
                ),
            ],
          )
      ),
    );
  }
}