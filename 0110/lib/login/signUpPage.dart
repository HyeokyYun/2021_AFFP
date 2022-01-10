import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'emailLoginPage.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'loginPage.dart';

class signUpPage extends StatefulWidget {
  @override
  signUp createState()=>signUp();
}

class signUp extends State<signUpPage> {
  bool _checkBoxValue = false;
  bool _checkBoxValue1 = false;
  bool _checkBoxValue2 = false;
  bool _checkBoxValue3 = false;

  bool isEnabled = false;
  bool isButtonActive = true;
  //
  // TextEditingController nameController;
  // TextEditingController emailController;
  // TextEditingController passwordController;

  bool _obscuretext = true;

  bool isCorrect  = true;
  @override
  initState() {
    TextEditingController nameController = new TextEditingController();
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,),
        centerTitle: true,
        title: Text('회원가입',
          style: TextStyle(fontSize: ScreenUtil().setSp(18),
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: ScreenUtil().setHeight(77)),
                // Text('회원가입 ',
                //   style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
                SizedBox(height: ScreenUtil().setHeight(87)),

                Container(
                  height: ScreenUtil().setHeight(43),
                  width: ScreenUtil().setWidth(287),
                  child: TextFormField(
                    //controller: emailController,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      hintText: '이메일',
                      contentPadding: EdgeInsets.all(15.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),

                SizedBox(height: ScreenUtil().setHeight(18)),
                Container(
                  height: ScreenUtil().setHeight(43),
                  width: ScreenUtil().setWidth(287),
                  child: TextFormField(
                    obscureText: _obscuretext,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: _obscuretext ? Colors.grey : Colors.black,
                        ),
                        onPressed: (){
                          setState(() {
                            _obscuretext = !_obscuretext;
                          });
                          // _controller.obscureChange;
                        },
                      ),
                      hintText: '비밀번호',
                      contentPadding: EdgeInsets.all(15.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                Container(
                  height: ScreenUtil().setHeight(43),
                  width: ScreenUtil().setWidth(287),
                  child: TextFormField(
                    obscureText: _obscuretext,

                    decoration: InputDecoration(
                      hintText: '비밀번호 확인',
                      contentPadding: EdgeInsets.all(15.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(18)),
                Container(
                  height: ScreenUtil().setHeight(43),
                  width: ScreenUtil().setWidth(287),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: '닉네임',
                      contentPadding: EdgeInsets.all(15.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(235)),
                SizedBox(
                    height: ScreenUtil().setHeight(55),
                    width: ScreenUtil().setHeight(400),
                    child: ElevatedButton(
                      onPressed: () {

                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return AlertDialog(
                                      // context: context,
                                        actions: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('이용약관 ',
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil().setSp(18),
                                                    ),
                                                  )
                                                  // IconButton(onPressed: (){},
                                                  //     icon: Icon(Icons.done))
                                                ],
                                              ),
                                              SizedBox(height: ScreenUtil().setHeight(50)),
                                              Row(
                                                  children: [
                                                    Checkbox(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                      ),
                                                      checkColor: Colors.white,
                                                      activeColor: Color(0xffFFAA00),
                                                      value: _checkBoxValue,
                                                      onChanged:(bool? value){
                                                        setState((){
                                                          _checkBoxValue =  value!;

                                                          if(_checkBoxValue == true) {
                                                            _checkBoxValue1 = true;
                                                            _checkBoxValue2 = true;
                                                            _checkBoxValue3 = true;

                                                            isEnabled = true;
                                                          };
                                                          if(_checkBoxValue == false) {
                                                            _checkBoxValue1 = false;
                                                            _checkBoxValue2 = false;
                                                            _checkBoxValue3 = false;
                                                            isEnabled = false;
                                                          };

                                                        });
                                                      },
                                                    ),

                                                    Text('약관 전체동의 '),
                                                  ]
                                              ),
                                              SizedBox(height: ScreenUtil().setHeight(4)),
                                              Container( height: 1, width: double.maxFinite, color: Colors.grey, ),

                                              SizedBox(height: ScreenUtil().setHeight(4)),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    // SizedBox(width: ScreenUtil().setWidth(15),),
                                                    Row(
                                                        children:[Checkbox(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          checkColor: Colors.white,
                                                          activeColor: Color(0xffFFAA00),
                                                          value: _checkBoxValue1,
                                                          onChanged:(bool? value){
                                                            setState((){
                                                              _checkBoxValue1 =  value!;

                                                              if( _checkBoxValue1 == false ) {
                                                                _checkBoxValue = false;
                                                                isEnabled = false;
                                                              };

                                                              if(_checkBoxValue1 ==  true &&_checkBoxValue2 ==  true &&_checkBoxValue3 ==  true ) {
                                                                isEnabled = true;
                                                              };

                                                            });
                                                          },
                                                        ),
                                                          Text('개인정보 수집 동의 (필수)'),
                                                        ]
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                        },
                                                        icon: Icon(Icons.arrow_forward_ios_rounded))
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Row(
                                                        children:[
                                                          Checkbox(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(15),
                                                            ),
                                                            checkColor: Colors.white,
                                                            activeColor: Color(0xffFFAA00),
                                                            value: _checkBoxValue2,
                                                            onChanged:(bool? value){
                                                              setState((){
                                                                _checkBoxValue2 =  value!;

                                                                if(_checkBoxValue2 == false ) {
                                                                  _checkBoxValue = false;
                                                                  isEnabled = false;
                                                                };
                                                                if(_checkBoxValue1 ==  true &&_checkBoxValue2 ==  true &&_checkBoxValue3 ==  true ) {
                                                                  isEnabled = true;
                                                                };
                                                              });
                                                            },
                                                          ),
                                                          Text('서비스 이용약관 동의 (필수)'),
                                                        ]),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(Icons
                                                            .arrow_forward_ios_rounded))
                                                  ]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Row(
                                                        children:[
                                                          Checkbox(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(15),
                                                            ),
                                                            checkColor: Colors.white,
                                                            activeColor: Color(0xffFFAA00),
                                                            value: _checkBoxValue3,
                                                            onChanged:(bool? value){
                                                              setState((){
                                                                _checkBoxValue3 =  value!;

                                                                if(_checkBoxValue3 == false ) {
                                                                  _checkBoxValue = false;
                                                                  isEnabled = false;
                                                                };
                                                                if(_checkBoxValue1 ==  true &&_checkBoxValue2 ==  true &&_checkBoxValue3 ==  true ) {
                                                                  isEnabled = true;
                                                                };
                                                              });
                                                            },
                                                          ),

                                                          Text('개인정보 수집 이용 (필수)'),]),
                                                    IconButton(onPressed: () {},
                                                        icon: Icon(Icons
                                                            .arrow_forward_ios_rounded))
                                                  ]
                                              ),
                                              SizedBox(width: ScreenUtil().setHeight(60),),

                                              Container(
                                                  height: ScreenUtil().setHeight(55),
                                                  width: ScreenUtil().setHeight(400),
                                                  child:
                                                  ElevatedButton(
                                                      onPressed: isEnabled ? () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => loginPage()),
                                                        );
                                                      } : null,
                                                      style: ElevatedButton.styleFrom(
                                                        primary: const Color(0xffFFAA00),

                                                      ),
                                                      child: Text('회원가입 완료')
                                                  )
                                              )
                                            ],
                                          )
                                        ]);
                                  }
                              );
                            }
                        );
                      },
                      child: Text(
                        '회원가입 계속 ',
                        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xffFFAA00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                      ),
                    )
                ),

                //SizedBox(height: ScreenUtil().setHeight(50)),
              ],
            ),

          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return '이메일을 입력하세요. ';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return '유효하지 않은 이메일 양식입니다. ';

  return null;
}