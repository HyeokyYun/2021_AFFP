import 'package:cap_ui_001/theme/colors.dart';
import 'package:cap_ui_001/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  String dropdownvalue = '가장 많이';
  var items = [
    '가장 많이',
    '가장 만족',
  ];
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
          color: Colors.black,
        ),
        title: SvgPicture.asset(
          "assets/appBar.svg",
          height: 27.h,
          width: 86.w,
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: AppColors.grey[600],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_sharp,
              color: AppColors.grey[600],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "도움으로 세상을 밝혀준 랭킹",
                    style: AppTextStyle.koBody2.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 74.w,
                  ),
                  DropdownButton(
                    value: dropdownvalue,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.grey[700],
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: AppTextStyle.koBody2.copyWith(
                            color: AppColors.grey[700],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: 340.w,
                height: 288.h,
                decoration: BoxDecoration(
                  color: AppColors.grey[50],
                  borderRadius: BorderRadius.circular(22.w),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey.withOpacity(0.1),
                      // spreadRadius: 5,
                      blurRadius: 20,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/1.png"
                        ),

                        Row(
                          children:[
                            ClipRRect(
                            borderRadius: BorderRadius.circular(57),
                            child: SvgPicture.asset(
                              "assets/profile.svg",
                              height: 38.h,
                              width: 38.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                            SizedBox(width:10.h),
                            Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Wegolego"),
                            Text("만능자"),
                            Text("#기계 #컴퓨터"),
                          ],
                        ),
                        ],
                        ),
                        Row(
                          children:[
                            Container(
                              height:15,
                              child: SvgPicture.asset("assets/heartIcon.svg"),
                            ),
                                Text("274"),
                            SizedBox(width: 10.w,),
                            Container(
                              height: 15,
                              child : Image.asset("assets/yellow_i.png"),
                            ),
                            Text("  593"),
                              ]
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                            "assets/2.png"
                        ),

                        Row(
                          children:[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(57),
                              child: SvgPicture.asset(
                                "assets/profile.svg",
                                height: 38.h,
                                width: 38.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width:10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Heonzyyy"),
                                Text("제빵사"),
                                Text("#쿠키 #파이"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                            children:[
                              Container(
                                height:15,
                                child: SvgPicture.asset("assets/heartIcon.svg"),
                              ),
                              Text("274"),
                              SizedBox(width: 10.w,),
                              Container(
                                height: 15,
                                child : Image.asset("assets/yellow_i.png"),
                              ),
                              Text("  593"),
                            ]
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                            "assets/3.png"
                        ),

                        Row(
                          children:[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(57),
                              child: SvgPicture.asset(
                                "assets/profile.svg",
                                height: 38.h,
                                width: 38.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width:10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Wegolego"),
                                Text("만능자"),
                                Text("#기계 #컴퓨터"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                            children:[
                              Container(
                                height:15,
                                child: SvgPicture.asset("assets/heartIcon.svg"),
                              ),
                              Text("274"),
                              SizedBox(width: 10.w,),
                              Container(
                                height: 15,
                                child : Image.asset("assets/yellow_i.png"),
                              ),
                              Text("  593"),
                            ]
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 44.h,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text(
                        "내가 남긴 감사편지",
                        style: AppTextStyle.koBody2
                            .copyWith(color: AppColors.secondaryColor[900]),
                      ),
                      Container(
                        width: 154.w,
                        decoration: BoxDecoration(
                          color: AppColors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.1),
                              // spreadRadius: 5,
                              blurRadius: 20,
                              offset: Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Grek",
                              style: TextStyle(
                                color: Colors.amber,
                              ), ),
                              Text(
                                '''감사해요
주변에 도움을 요청할
곳이 없어서 난감했는데
덕분에 잘 해결할 수 있었
니다! 감사해요 ''',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                           Divider(
                             thickness: 1,
                             color: Colors.grey,
                             indent: 10.w,
                             endIndent: 10.w,
                           ),
                            Text(
                              "Grek",
                              style: TextStyle(
                                color: Colors.amber,
                              ), ),
                            Text(
                               '''여기서 궁금증을 해결할
지 몰랐네요 
덕분에 잘 알아가요''',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),


                          ],
                        )
                      ),

                    ],
                  ),
                  //
                  VerticalDivider(
                    thickness: 10,
                    color: Colors.red,
                  ),

                  Column(
                    children: [
                      Text(
                        "내가 받은 감사편지",
                        style: AppTextStyle.koBody2
                            .copyWith(color: AppColors.secondaryColor[900]),
                      ),
                      Container(
                        width: 154.w,
                        decoration: BoxDecoration(
                          color: AppColors.grey[50],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.grey
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.1),
                              // spreadRadius: 5,
                              blurRadius: 20,
                              offset: Offset(0, 5), // changes position of shadow
                            ),
                          ],
                        ),
                          child: Column(
                            children: [
                              Text(
                                "Grek",
                                style: TextStyle(
                                  color: Colors.amber,
                                ), ),
                              Text(
                                '''감사해요
주변에 도움을 요청할
곳이 없어서 난감했는데
덕분에 잘 해결할 수 있었
니다! 감사해요 ''',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                                indent: 10.w,
                                endIndent: 10.w,
                              ),
                              Text(
                                "Grek",
                                style: TextStyle(
                                  color: Colors.amber,
                                ), ),
                              Text(
                                '''여기서 궁금증을 해결할
지 몰랐네요 
덕분에 잘 알아가요''',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),


                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
