import 'package:des_dev_camp2021/Theme/colors.dart';
import 'package:des_dev_camp2021/Theme/text_styles.dart';
import 'package:des_dev_camp2021/agora/call.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _channelController = 'test';
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  @override
  Widget build(BuildContext context) {
    //return GetBuilder<DashboardController>(
    //    builder: (controller) {
    return Scaffold(
      backgroundColor: Color(0xffe5ddca),
      appBar: AppBar(
        title: Text(
          '무물',
          style: TextStyle(color: Colors.black, letterSpacing: 2.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            Get.offAllNamed('/login');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
        backgroundColor: Color(0xffe5ddca),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Column(
            children: [
              Container(
                width: 167.0,
                height: 250.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage("https://i.imgur.com/amL8zho.png"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Expanded(
            child: Align(
              //alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),

                            //여기부터
                            //overlay,

                            //여기까지
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                ),
                                VerticalDivider(
                                  color: onSurface,
                                  thickness: 1.0,
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       '나의 식물',
                                //       style: body1Style(),
                                //     ),
                                //     Text(
                                //       '무럭 무럭 자라고 있어요',
                                //       style: body2Style(
                                //         color: onSurface.withOpacity(0.4),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      //버튼 사이즈
                      height: 130,
                      width: 500,
                      padding: EdgeInsets.all(13),
                      child: ElevatedButton(
                        onPressed: onJoin,
                        child: SizedBox(
                          width: 400,
                          child: Center(child: Text('도움 요청하기')),
                        ),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 25.0,
                            fontFamily: GoogleFonts.notoSans().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
  Future<void> onJoin() async {
    // update input validation
    // setState(() {
    //   _channelController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
    if (_channelController.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
