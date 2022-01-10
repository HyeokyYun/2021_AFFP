import 'signUpPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../navigation.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'emailLoginPage.dart';
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
  @override
  Widget build(BuildContext context) {
    // Get.put(welcomeController());
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
                      if (value == 2)
                        Get.find<welcomeController>().changetrue();
                      else
                        Get.find<welcomeController>().changefalse();
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
                                onPressed: () {
                                  // Get.to(page)
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Navigation()),
                                  );
                                },
                                child: Text(
                                  '시작하기',
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
  return Container(
      child: Column(children: [
    Text(
      '라이큐와 함께 해주셔서',
      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
    ),
    Text(
      '감사합니다! ',
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
      '세상의 모든 인재가 당신을 도와줄거에요',
      style: TextStyle(fontSize: ScreenUtil().setSp(16)),
    ),
    SizedBox(
      height: ScreenUtil().setHeight(9),
    ),
    Text(
      '라이큐 : 실시간 영상을 통해',
      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
    ),
    Text(
      '누구나 도움을 주고 받을 수 있는 서비스',
      style: TextStyle(fontSize: ScreenUtil().setSp(14)),
    ),
  ]));
}

Widget _step2() {
  return Container(
      child: Column(children: [
    Column(children: [
      Text(
        '라이큐와 함께 해주셔서',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      Text(
        '감사합니다! ',
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
        '답변자가 되어 도움을 주세요',
        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(9),
      ),
      Text(
        '자신있는 분야에 대해',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
      Text(
        '답변해서 세상을 밝혀주세요',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
    ]),
  ]));
}

Widget _step3() {
  return Container(
      child: Column(children: [
    Column(children: [
      Text(
        '라이큐에 오신 모두 ',
        style: TextStyle(fontSize: ScreenUtil().setSp(18)),
      ),
      Text(
        '환영합니다! ',
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
        '질문자가 되어 도움을 받아보세요',
        style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      ),
      SizedBox(
        height: ScreenUtil().setHeight(9),
      ),
      Text(
        '궁금한 분야를 답변자에게 실시간으로',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
      Text(
        '직접 묻고 답변을 받을 수 있어요',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)),
      ),
    ]),
  ]));
}
