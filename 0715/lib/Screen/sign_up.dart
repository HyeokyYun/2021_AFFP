import 'package:des_dev_camp2021/Theme/colors.dart';
import 'package:des_dev_camp2021/Widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title:'회원가입',
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox (
                  height: 50.0
              ),
              Text('사용자 이름'),
              TextFormField(
                decoration: InputDecoration(
                    hintText: '이름 입력해주세요',
                  hintStyle: TextStyle(
                      color: Colors.green[200]
                  ),
                ),
              ),
              SizedBox (
                  height: 30.0
              ),
              Text('ID'),
              SizedBox (
                  height: 10.0
              ),
              TextFormField(
                decoration: InputDecoration(
                    suffixIcon: SizedBox(
                      height: 0,
                      child: IconButton(
                        iconSize: 65,
                        onPressed: (){
                        },
                        icon: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: secondary[100]
                          ),
                          onPressed: (){},
                          child: Text('중복확인',
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                    hintText: '아이디를 입력해주세요',
                hintStyle: TextStyle(
                    color: Colors.green[200]
                ),
                ),
              ),
              SizedBox (
                  height: 30.0
              ),
              Text('PW'),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (){
                    },
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  hintText: '비밀번호를 입력해주세요',
                  hintStyle: TextStyle(
                    color: Colors.green[200]
                  ),
                ),
                onSaved: (String? value){

                },
              ),
              SizedBox (
                  height: 50.0
              ),
              Center(
                child: ElevatedButton(
                    onPressed:(){
                      Get.toNamed('/login');
                    } ,
                    child: Text(
                        '회원가입'
                    )
                ),
              ),
            ]
        ),
      ),
    );
  }
}