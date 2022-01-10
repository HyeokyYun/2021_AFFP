import 'package:flutter/material.dart';
import 'GetxController.dart';
import 'animated_radial_menu.dart';
import '../myPage/mypage.dart';
import 'package:get/get.dart';
import '../pages/rakingPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/guidePage.dart';

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: SvgPicture.asset(
            "assets/appBar.svg",
            height: 27,
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications_rounded,
                color: Colors.grey[400],
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.grey[400],
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "세상의 모든 인재들이 모인 공간",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff343A40)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "참여 중인 답변자",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff343A40)),
                  ),
                  Text(
                    "294,201",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF57F17),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 440,
                  ),
                  Icon(Icons.arrow_drop_up, color: Color(0xffADB5BD)),
                  Icon(Icons.arrow_drop_up, color: Color(0xffADB5BD)),
                  Text(
                    '고민말고 도움을 요청하세요',
                    style: TextStyle(color: Color(0xff868E96)),
                    // style: bodyhighlightStyle(
                    //   color: Colors.black,
                    //   fontsize: 12,
                    //   height: 1.5,
                    // ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 59,
                        width: 151,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => guidePage()),
                            );
                          },
                          child: Text(
                            "사용설명서",
                            style: TextStyle(color: Color(0xff6F7378)),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffFFFFFF),
                            padding: EdgeInsets.all(20),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        height: 59,
                        width: 151,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RankingPage()),
                            );
                          },
                          child: Text(
                            "랭킹",
                            style: TextStyle(color: Color(0xff6F7378)),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffFFFFFF),
                            padding: EdgeInsets.all(20),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            GetBuilder<BuilderController>(
                init: BuilderController(),
                builder: (_) {
                  return _.dark
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black.withOpacity(0.8),
                        );
                }),

            Column(
              children: [
                SizedBox(
                  height: 170,
                ),
                RadialMenu(
                  children: [
                    RadialButton(
                        icon: Icon(Icons.ac_unit, color: Color(0xff7B7B7B)),
                        buttonColor: Color(0xffF8F9FA),
                        style: pressed
                            ? ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.focused))
                                    return Colors.red;
                                  if (states.contains(MaterialState.hovered))
                                    return Colors.green;
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.blue;
                                  return Colors
                                      .red; // Defer to the widget's default.
                                }),
                              )
                            : ButtonStyle(),
                        onPress: () {
                          setState(() {
                            pressed = !pressed;
                          });
                        }),
                    RadialButton(
                        icon: Icon(Icons.camera_alt, color: Color(0xff7B7B7B)),
                        buttonColor: Color(0xffF8F9FA),
                        style: pressed ? ButtonStyle() : ButtonStyle(),
                        onPress: () {
                          setState(() {
                            pressed = !pressed;
                          });
                        }),
                    RadialButton(
                        icon: Icon(Icons.map, color: Color(0xff7B7B7B)),
                        buttonColor: Color(0xffF8F9FA),
                        style: pressed ? ButtonStyle() : ButtonStyle(),
                        onPress: () {
                          setState(() {
                            pressed = !pressed;
                          });
                        }),
                    RadialButton(
                        icon:
                            Icon(Icons.access_alarm, color: Color(0xff7B7B7B)),
                        buttonColor: Color(0xffF8F9FA),
                        style: pressed ? ButtonStyle() : ButtonStyle(),
                        onPress: () {
                          setState(() {
                            pressed = !pressed;
                          });
                        }),
                    RadialButton(
                        icon: Icon(Icons.watch, color: Color(0xff7B7B7B)),
                        buttonColor: Color(0xffF8F9FA),
                        style: pressed ? ButtonStyle() : ButtonStyle(),
                        onPress: () {
                          setState(() {
                            pressed = !pressed;
                          });
                        }),
                  ],
                ),
              ],
            ),
            // Positioned(
            //   top: 30,
            //   left: 10,
            //   child: ElevatedButton(
            //       onPressed: () {
            //         if (Get.isDarkMode) {
            //           Get.changeTheme(ThemeData.light());
            //         } else {
            //           Get.changeTheme(ThemeData.dark());
            //         }
            //       },
            //       child: Text("change Theme")),
            // ),
          ],
        ),
      ),
    );
  }
}
