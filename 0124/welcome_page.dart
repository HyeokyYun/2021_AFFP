import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class welcomeController extends GetxController {
  late bool startBut = false;

  changetrue() {
    startBut = true;
    update();
  }

  changefalse() {
    startBut = false;
    update();
  }
}

// ignore: camel_case_types
class welcomePage extends StatefulWidget {
  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {

  FirebaseAuth auth = FirebaseAuth.instance;
  User? get userProfile => auth.currentUser;

  @override
  Widget build(BuildContext context) {
    Get.put(welcomeController());
    bool getindex = false;
    final List<Widget> steps = [
      _step1(),
      _step2(),
      _step3(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints.expand(height: 480),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return steps[index];
                    },
                    onIndexChanged: (value) {
                      if (value == 2) {
                        Get.find<welcomeController>().changetrue();
                      } else {
                        Get.find<welcomeController>().changefalse();
                      }
                    },
                    loop: false,
                    autoplay: true,
                    itemCount: steps.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.grey[200],
                        activeColor: Color(0XFF874BD9),
                      ),
                    ),
                  ),
                ),
                GetBuilder<welcomeController>(
                    init: welcomeController(),
                    builder: (_) {
                      return _.startBut
                          ? SizedBox(
                        height: ScreenUtil().setHeight(55),
                        width: ScreenUtil().setHeight(400),
                        child: ElevatedButton(
                          onPressed: () async {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(userProfile!.uid)
                                .update({"first time": true});
                            // Get.to(page)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navigation()),
                            );
                          },
                          child: Text(
                            '????????????',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(14)),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffFFAA00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(33),
                            ),
                          ),
                        ),
                      )
                          : Container(
                        height: ScreenUtil().setHeight(55),
                      );
                    }),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget _step1() {
  return Column(children: [
    Text(
      '???????????? ?????? ????????????',
      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
    ),
    Text(
      '???????????????! ',
      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
    ),
    SizedBox(
      height: 30,
    ),
    Container(
      color: Color(0xffEDE9FE),
      height: ScreenUtil().setHeight(205),
      width: ScreenUtil().setWidth(340),
      child: SvgPicture.asset(
        'assets/img2.svg',
      ),
    ),
    SizedBox(height: ScreenUtil().setHeight(20)),
    Text(
      '????????? ?????? ????????? ????????? ??????????????????',
      style: TextStyle(fontSize: ScreenUtil().setSp(16)),
    ),
    SizedBox(
      height: ScreenUtil().setHeight(9),
    ),
    Text(
      '????????? : ????????? ????????? ??????',
      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
    ),
    Text(
      '????????? ????????? ?????? ?????? ??? ?????? ?????????',
      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
    ),
  ]);
}

Widget _step2() {
  return Column(children: [
    Column(children: [
      Text(
        '???????????? ?????? ????????????',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      Text(
        '???????????????! ',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        color: Color(0xffEDE9FE),
        height: ScreenUtil().setHeight(205),
        width: ScreenUtil().setWidth(340),
        child: SvgPicture.asset(
          'assets/img1.svg',
        ),
      ),
      SizedBox(height: ScreenUtil().setHeight(20)),
      Text(
        '???????????? ?????? ????????? ?????????',
        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(9),
      ),
      Text(
        '???????????? ????????? ??????',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
      Text(
        '???????????? ????????? ???????????????',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
    ]),
  ]);
}

Widget _step3() {
  return Column(children: [
    Column(children: [
      Text(
        '???????????? ?????? ?????? ',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      Text(
        '???????????????! ',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        color: Color(0xffFFF9C4),
        height: ScreenUtil().setHeight(205),
        width: ScreenUtil().setWidth(340),
        child: SvgPicture.asset(
          'assets/img3.svg',
        ),
      ),
      SizedBox(height: ScreenUtil().setHeight(20)),
      Text(
        '???????????? ?????? ????????? ???????????????',
        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(9),
      ),
      Text(
        '????????? ????????? ??????????????? ???????????????',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
      Text(
        '?????? ?????? ????????? ?????? ??? ?????????',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
    ]),
  ]);
}
