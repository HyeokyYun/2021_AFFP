import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:self_study5/agorafunc/call.dart';
import 'package:self_study5/app/modules/home/controllers/welcome_controller.dart';
import 'dart:async';

class WelcomeView extends GetView<WelcomeController> {
  late String _channelController; // ㅇㅕㄱ에 사용자 uid insert
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  // void initState(){
  //   _channelController = controller.user.uid;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'User Profile',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 16,
            ),
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(controller.user.photoURL!),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Display Name : ${controller.user.displayName}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              controller.user.email!,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "UID: ${controller.user.uid}",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 120),
              child: ElevatedButton(
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onPressed: () {
                  controller.logout();
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed:() async {
                _channelController = controller.user.uid;
                print("UID(Channel Name): ${_channelController}");
                if (_channelController.isNotEmpty) {
                  //print("UID is Channel");
                  // await for camera and mic permissions before pushing video page
                  await _handleCameraAndMic(Permission.camera);
                  await _handleCameraAndMic(Permission.microphone);
                  // push video page with given channel name
                  await Get.to(()=>CallPage(
                    channelName: _channelController,
                    role: _role,
                  ));}
                },
                child: Center(
                child: Text(
                  "Ask",
                  style: TextStyle(fontSize: 16, color: Colors.black),),
                ),
            )
          ],
        ),
      ),
    );
  }
  // Future<void> onJoin() async {
  //   _channelController = controller.user.uid;
  //   // update input validation
  //   // setState(() {
  //   //   _channelController.text.isEmpty
  //   //       ? _validateError = true
  //   //       : _validateError = false;
  //   // });
  //   if (_channelController.isNotEmpty) {
  //     print("Not Empty");
  //     // await for camera and mic permissions before pushing video page
  //     await _handleCameraAndMic(Permission.camera);
  //     await _handleCameraAndMic(Permission.microphone);
  //     // push video page with given channel name
  //     await Get.to(CallPage(
  //       channelName: _channelController,
  //       role: _role,
  //     ));
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => CallPage(
  //     //       channelName: _channelController,
  //     //       role: _role,
  //     //     ),
  //     //   ),
  //     // );
  //   }
  // }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}