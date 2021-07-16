import 'package:des_dev_camp2021/Theme/colors.dart';
import 'package:des_dev_camp2021/Theme/text_styles.dart';
import 'package:des_dev_camp2021/Widget/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5ddca),
      appBar: AppBar(
        backgroundColor: Color(0xffe5ddca),
        elevation: 0.0,
        title: Text(
          '사용자 정보',
          style: TextStyle(color: Colors.black,
            letterSpacing: 2.0
          ),
        ),
      ),
      // customAppBar(
      //   title: '사용자 정보',
      //   automaticallyImplyLeading: false,
      // ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                color: onSurface[50],
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(-1.0, 4.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  new Container(
                    width: 85.0,
                    height: 85.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("https://ifh.cc/g/2Bez3i.jpg"),
                      ),
                    ),
                  ),
                  //사진 넣기
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '수호천사 ',
                        style: body2Style(color: onSurface.withOpacity(0.6)),
                      ),
                      Text(
                        '김 위고레고',
                        style: body2Style(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ListTile(
                        //   leading: Text("front!"),
                        //   trailing: Text("back!"),
                        // ),
                        Text("언어", style: body2Style()),
                        SizedBox(
                          width: 200,
                        ),
                        Text(
                          "한국어",
                          style: body2Style(color: onSurface.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ListTile(
                        //   leading: Text("front!"),
                        //   trailing: Text("back!"),
                        // ),
                        Text("내분야", style: body2Style(color: onSurface)),
                        SizedBox(
                          width: 180,
                        ),
                        Text(
                          "레고조립",
                          style: body2Style(color: onSurface.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: onSurface[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Text(
                          '연령대',
                          style: body1Style(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Divider(
                        color: onSurface,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Text(
                          '언어',
                          style: body1Style(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Divider(
                        color: onSurface,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Text(
                          '관심분야',
                          style: body1Style(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Divider(
                        color: onSurface,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}