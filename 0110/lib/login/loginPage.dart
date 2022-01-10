import '../login/signUpPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'emailLoginPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(140)),

              Container(
                height: ScreenUtil().setHeight(115),
                width: ScreenUtil().setWidth(86),
                child: SvgPicture.asset(
                  'assets/liveQ_logo.svg',
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(22)),
              Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '도움',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: Color(0xFFffaa00)),
                  ),
                  Text(
                    '과',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: Color(0xFF5B21B6)),
                  ),
                  Text(
                    '소통',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: Color(0xFFffaa00)),
                  ),
                  Text(
                    '의 제한 없는 공간',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: Color(0xFF5B21B6)),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '라이큐',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(22),
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5B21B6)),
                  ),
                ]),
                SizedBox(height: ScreenUtil().setHeight(9)),
                Text(
                  '세상의 모든 어려움의',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Color(0xFF979797)),
                ),
                Text(
                  '장벽을 허물어주는 어플',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Color(0xFF979797)),
                ),
              ]),

              SizedBox(height: ScreenUtil().setHeight(47)),
              SizedBox(
                  height: ScreenUtil().setHeight(55),
                  width: ScreenUtil().setHeight(400),
                  child: ElevatedButton(
                    onPressed: () {
                      // Get.to(emailLoginPage());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => emailLoginPage()),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/google.svg'),
                        Padding(
                          padding: EdgeInsets.only(left: 33.0),
                          child: Text(
                            '구글 계정으로 로그인',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    // child: Text(
                    //   '구글 계정으로 로그인',
                    //   style: TextStyle(fontSize: ScreenUtil().setSp(14),
                    //   color: Colors.black),
                    // ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                    ),
                  )),
              SizedBox(height: ScreenUtil().setHeight(20)),
              SizedBox(
                height: ScreenUtil().setHeight(55),
                width: ScreenUtil().setHeight(400),
                child: ElevatedButton(
                  onPressed: () {
                    // Get.to(emailLoginPage());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => emailLoginPage()),
                    );  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => emailLoginPage()),
                    );
                  },
                  child: Text(
                    '이메일 계정으로 로그인',
                    style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffFFAA00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33),
                    ),
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    // Get.to(signUpPage());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => signUpPage()),
                    );
                  },
                ),
              ),
              //SizedBox(height: ScreenUtil().setHeight(50)),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
