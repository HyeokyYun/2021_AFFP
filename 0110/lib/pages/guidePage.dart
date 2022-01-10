import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class guidePage extends StatefulWidget {
  const guidePage({Key? key}) : super(key: key);

  @override
  _guidePageState createState() => _guidePageState();
}

class _guidePageState extends State<guidePage> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> steps = [
      _step1(),
      _step2(),
      _step3(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "사용 설명서",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,),
      ),

      body: Container(
        child: Padding(
          padding: EdgeInsets.all(0.0),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 30.0),
                Container(
                  constraints: const BoxConstraints.expand(
                      height: 600,
                      width: 376
                  ),
                  child :
                  Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return steps[index];
                    },
                    loop: false,
                    autoplay: false,
                    //autoplayDelay: 7000,
                    itemCount: 3,
                    viewportFraction: 1.0,
                    scale: 0.9,

                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.grey[200],
                          activeColor: Color(0XFF874BD9)),
                    ),

                    //control: new SwiperController(),
                  ),
                  //
                )

              ],
            ),
          ),
        ),
    ));
  }
}



Widget _step1() {
  return Container(
    padding: EdgeInsets.all(10.0),
      child: Expanded(
        child: Column(
            children: [
          Container(
            child: Image.asset(
              "assets/icons.png",
              height: 218,
              width: 205,

            ),
          ),
              SizedBox(height: 30.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(width: 5,),

            Column(
              children:[
                SizedBox(height: 6.h),
                Image.asset(
                "assets/1.png",
              ),
            ]
            ),
            Text('''카테고리를
선택해보세요''',
              style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
            Text ('''지금 도움이 필요한 분야가
무엇인지 선택해주세요
대중교통, 공부, 운동, 음식, 
애완동물 등 여러분야의 
문제에 답변해드릴게요 ''')
          ]
          )
        ]),
      ));
}

Widget _step2() {
  return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(children: [

        Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/ask_button.png",
                  height: 218,
                  width: 205,
                ),
              ),
              SizedBox( height: 32.h,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox(width: 5,),
                    Column(
                        children:[
                          SizedBox(height: 6.h),
                          Image.asset(
                            "assets/2.png",
                          ),
                        ]
                    ),
                    Text('''
질문자가 되어
도움을
받아보세요 ''',
                      style: TextStyle(fontSize: ScreenUtil().setSp(18)),),
                    Text ('''궁금한 분야를 답변자에게
자신의 영상을 공유하며 
실시간으로 직접 묻고 
답변을 받을 수 있어요''')
                  ]
              )
              ]
            ),
      ]));
}

Widget _step3() {
  return Container(
      child: Column(
          children: [
        Column(
            children: [
              SizedBox(height: 100.h,),
              Container(
                height: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 17,
                            child: SvgPicture.asset(
                              "assets/heartIcon.svg",
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                "받은 하트",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 19,
                            child: Image.asset(
                              "assets/yellow_i.png",
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "응답 횟수",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 18,
                            child: Image.asset(
                              "assets/star_icon.png",
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "질문 횟수",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100.h),
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(width: 5,),
                        Column(
                            children:[
                              SizedBox(height: 6.h),
                              Image.asset(
                                "assets/3.png",
                              ),
                            ]
                        ),
                          Column(
                            children: [
                              Text('''답변자가 되어
도움을 주세요 ''',
                                style: TextStyle(fontSize: ScreenUtil().setSp(18)),),

                              SizedBox(height: 70.h,),
                              Image.asset(
  "assets/Vector.png",
)
                            ],
                          ),
 Text ('''실시간 질문방에 입장하여
다른 사람들의 질문에
바로 답변할 수 있어요!
자신있는 분야에 참여해서 
도움을 주세요

직접 화면에 그리는 기능을
다른 사람들의 질문에
바로 답변할 수 있어요!
자신있는 분야에 참여해서 
도움을 주세요
'''),
                      ]),
                  SizedBox(height: 32.h,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(width: 30.w,),
//                       Container(
//                         height: 29,
//                         width: 24,
//                         child: Image.asset(
//                           "assets/Vector.png",
//                         ),
//                       ),
//                       Text ('''직접 화면에 그리는 기능을
// 다른 사람들의 질문에
// 바로 답변할 수 있어요!
// 자신있는 분야에 참여해서
// 도움을 주세요'''),]
//                   )
                  ]
              )
            ]),
      ]));
}
