import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wegolego_v015/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:wegolego_v015/push_notification/push_notification_service.dart';
import 'package:wegolego_v015/screens/agora/pages/call_taker.dart';

import '../../config.dart';
import 'channel/channel_list.dart';

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

  List<String> tokens = [];
  Future<int> countUsers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    for (var element in querySnapshot.docs) {
      tokens.add((element.data() as dynamic)["uid"]);
    }
    return tokens.length;
  }
  intCount() async {
    int count = await countUsers();
    return count;
  }

  @override
  void initState() async {
    int _count = await countUsers();
    super.initState();
  }

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    print("HOME is signed in: ${_authController.isSignedIn}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('LivQ',
          style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => {
              _authController.signout()},
            icon: const Icon(Icons.logout, color: Color(0xff343A40)),
            iconSize: Config.screenWidth! * 0.065,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    Config.screenWidth! * 0.2,
                    0,
                    Config.screenHeight! * 0.08,
                  ),
                  width: Config.screenWidth,
                  //height:
                  color: const Color(0xffFCF3CA),
                  child: Column(
                    children: [
                      Text('Hello, "${_authController.displayName.toString().capitalizeString()}" !',
                        style: TextStyle(
                          fontSize: Config.screenWidth! * 0.05,
                        ),
                      ),
                      Text(
                        'Press ASK button with no fear!',
                        style: TextStyle(
                          fontSize: Config.screenWidth! * 0.04,
                        ),
                      ),
                      Text(
                        '${intCount()} Users Are With You',
                        style: TextStyle(
                          fontSize: Config.screenWidth! * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: Config.screenWidth! * 0.73,
                    ),
                    Container(
                      padding: EdgeInsets.all(Config.screenWidth! * 0.03),
                      width: MediaQuery.of(context).size.width * 0.4,
                      //157,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: const BoxDecoration(
                        color: Color(0xffF6FBF8),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffADB5BD),
                            offset: Offset(-0.26, 0.81),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: ElevatedButton(
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
                                    "uid": firebaseUser!.uid,
                                    "name": _authController.displayName
                                  }
                              );
                            });
                            await NotificationService.sendNotification(
                                "${_authController.displayName} needs your HELP!", "Join To Help"
                            );
                            await _handleCameraAndMic(Permission.camera);
                            await _handleCameraAndMic(Permission.microphone);
                            // push video page with given channel name
                            String channel = FirebaseAuth.instance.currentUser!.uid;
                            await Get.to(() => CallPage_taker(
                              channelName: channel,
                              //  role: _role,
                            ));
                          },
                          child: Text(
                            'Ask',
                            style: TextStyle(
                              //  color: Color(0xff3F5A49),
                              fontSize: Config.screenWidth! * 0.09,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.all(Config.screenWidth! * 0.05),
                            primary: const Color(0xff3F5A49),
                          )),
                    ),
                    SizedBox(
                        width: Config.screenWidth! * 0.7,
                        height: Config.screenHeight! * 0.07,
                        child: ElevatedButton(
                          onPressed: () async {
                            Get.to(() => const ChannelList());
                          },
                          child: Text(
                            "Help Requests",
                            style: TextStyle(fontSize: Config.screenWidth! * 0.05),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff7EA68D),
                            //padding: EdgeInsets.all(Config.screenWidth! * 0.02),
                          ),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}