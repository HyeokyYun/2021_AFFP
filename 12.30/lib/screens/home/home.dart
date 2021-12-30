import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cap_007_auth_noti/controllers/auth_controller.dart';
import 'package:cap_007_auth_noti/push_notification/push_notification.dart';
import 'package:cap_007_auth_noti/screens/chennels/chennel_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'agora/pages/call_helper.dart';
import 'agora/pages/call_taker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ClientRole? _role = ClientRole.Broadcaster;

  FirebaseAuth auth = FirebaseAuth.instance;

  User? get userProfile => auth.currentUser;
  User? currentUser;

  var firebaseUser = FirebaseAuth.instance.currentUser;
  final _channelController = TextEditingController();


  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LivQ'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: GetBuilder<AuthController>(
              builder: (_authController) {
                return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Hello ${_authController.displayName.toString()
                            .capitalizeString()}!'),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: ElevatedButton(
                                      //페이지 넘기기
                                      onPressed: () async {
                                        setState(() {
                                          FirebaseFirestore.instance.collection("videoCall")
                                              .doc(firebaseUser!.uid)
                                              .set(
                                              {
                                                "count": 1,
                                                "timeRegister": DateTime
                                                    .now()
                                                    .millisecondsSinceEpoch
                                                    .toString(),
                                                "uid": firebaseUser!.uid
                                              }
                                          );
                                          // _channelController.text.isEmpty
                                          //     ? _validateError = true
                                          //     : _validateError = false;
                                        });
                                        await NotificationService.sendNotification(
                                            "${firebaseUser!.displayName}", "${firebaseUser!.email}"
                                        );

                                        await _handleCameraAndMic(Permission.camera);
                                        await _handleCameraAndMic(Permission.microphone);
                                        // push video page with given channel name
                                        String channel = FirebaseAuth.instance.currentUser!.uid;
                                        await Get.to(() => CallPage_taker(
                                          channelName: channel,
                                          //  role: _role,
                                        ));
                                      }, //onJoin,
                                      child: const Text('Join'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(Colors.blueAccent),
                                          foregroundColor:
                                          MaterialStateProperty.all(Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        ElevatedButton(onPressed: (){
                          Get.to(() => const ChannelList());
                        }, child: const Text("Channel Lists")),

                        ElevatedButton(
                          child: const Text('Sign out') ,
                          onPressed: () => {
                            FirebaseFirestore.instance.collection('users').doc(userProfile!.uid).update(
                                {'token' : FieldValue.delete()}),
                            _authController.signout()},
                        ),
                      ],
                    ));
              },
            )),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      FirebaseFirestore.instance.collection("videoCall")
          .doc(firebaseUser!.uid)
          .set(
          {
            "count": 1,
            "timeRegister": DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            "uid": firebaseUser!.uid
          }
      );
      // _channelController.text.isEmpty
      //     ? _validateError = true
      //     : _validateError = false;
    });
    if (firebaseUser!.uid.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      print("Uid(Channel Name): $_channelController");
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      // 여기서 나누어야 함.

      if (_role.toString().compareTo("ClientRole.Broadcaster") == 0) {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CallPage_taker(
                    channelName: firebaseUser!.uid,
                    //role: _role,
                  )),
        );
      } else {
        //Helper일때
        /*
        카메라 view[1]로 보여야하고
        이 사람이 그려야함
        drawing을 받는 부분은 안나타 나면 된다.
        */
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CallPage_helper(
                  channelName: _channelController.text,
                  //role: ClientRole.Broadcaster,
                ),
          ),
        );
        // await Get.to(CallPage_helper(
        //   channelName: _channelController.text,
        // ));
      }
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}