import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:wegolego_jjinjjin_0907/agorafunc/call_taker.dart';
import 'package:wegolego_jjinjjin_0907/pages/channel_list/channel_list_page.dart';
import 'package:wegolego_jjinjjin_0907/pages/login/login_controller.dart';
import 'package:wegolego_jjinjjin_0907/pushService/pushNotificationService.dart';
import 'package:wegolego_jjinjjin_0907/themes/colors.dart';
import 'package:wegolego_jjinjjin_0907/themes/text_style.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomePageController> {
  DatabaseReference db = new FirebaseDatabase().reference().child("Count").child("count");
  late String count;
  HomePageController homeController = Get.find<HomePageController>();
  LoginPageController loginPageController = Get.find<LoginPageController>();

  final GoogleSignIn googleSignIn = GoogleSignIn();

  late String _channelController; // ㅇㅕㄱ에 사용자 uid insert
  //String? _channelController;
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  // void initState(){
  //   _channelController = controller.user.uid;
  // }

  // realtime database
  get app => null;
  final referenceDatabase = FirebaseDatabase.instance;
  final uid = 'uid';
  late DatabaseReference _uidRef;

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: this.app);
    _uidRef = database.reference().child('Uids');

    initState();
  }

  @override
  Widget build(BuildContext context) {
    final _inactiveColor = Colors.grey;
    final ref = referenceDatabase.reference();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MooMool',
          style: appbarstyle(),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 12.0, 0),
            onPressed: () {},
            //추가적인 안내가 없다면 Icons.notifications
            icon: Icon(
              Icons.notifications_active,
              color: primary,
            ),
            iconSize: 28.0,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.20,
                      0,
                      MediaQuery.of(context).size.height * 0.13,
                    ),
                    width: MediaQuery.of(context).size.width,
                    //height:
                    color: Color(0xffFCF3CA),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StreamBuilder(
                              stream: db.onValue,
                              builder: (context, AsyncSnapshot<Event> snap) {
                                if (!snap.hasData)return Text("데이터 없음");
                                return Text(snap.data!.snapshot.value.toString(), style: bodyhighlightStyle(
                                  fontWeight: FontWeight.bold,
                                  fontsize: 28.0,
                                ), );
                              },
                            ),
                            Text(
                              ' 명의',
                              style: bodyhighlightStyle(
                                color: onSurface[900],
                                fontsize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'helper',
                              style: bodyhighlightStyle(
                                color: tertiary,
                                fontsize: 20,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              '가 참여하고 있습니다.',
                              style: bodyhighlightStyle(
                                color: onSurface[900],
                                fontsize: 20,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text(
                          '고민말고 도움을 요청하세요',
                          style: bodyhighlightStyle(
                            color: onSurface[600],
                            fontsize: 12,
                            height: 1.5,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: onSurface[600]),
                        Icon(Icons.arrow_drop_down, color: onSurface[600]),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //WheelExample(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.37,
                      ),
                      Container(
                        padding: EdgeInsets.all(13),
                        width: MediaQuery.of(context).size.width * 0.4,
                        //157,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: primary[50],
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: onSurface,
                              offset: Offset(-0.26, 0.81),
                              blurRadius: 3.11,
                            )
                          ],
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              _channelController =
                                  FirebaseAuth.instance.currentUser!.uid;
                              print("UID(Channel Name): $_channelController");

                              ref.child('Uids').push().update(
                                  {'uid': _channelController}).asStream();

                              Get.bottomSheet(Popup());
                            },
                            child: Text(
                              'Ask',
                              style: TextStyle(
                                color: onSurface[50],
                                fontSize: 32,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                              primary: primary[700],
                            )),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await Get.to(() => ListPage());
                        },
                        child: Center(
                          child: Text(
                            "Channel List",
                            style: body16Style(color: onSurface[50]),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: primary,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
          //이부분에 기존 코드가 들어감
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      print("Not Empty");
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Get.to(() => CallPage_taker(
        channelName: loginPageController.currentUser!.uid,
        //_channelController,
        //  role: _role,
      ));
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}

class Popup extends GetView<HomePageController> {
  late String _channelController;

//  HomePageController homeController = Get.find<HomePageController>();
  LoginPageController loginPageController = Get.find<LoginPageController>();
  final _scrollController = FixedExtentScrollController();

  static const double _itemHeight = 60;
  static const int _itemCount = 6;
  late int tap_question;
  int which_question = 0;
  late bool textbox;
  final referenceDatabase = FirebaseDatabase.instance;
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final ref = referenceDatabase.reference();

    return Container(
      child: ClickableListWheelScrollView(
        scrollController: _scrollController,
        itemHeight: _itemHeight,
        itemCount: _itemCount,
        onItemTapCallback: (index) {
          tap_question = index;
          if (tap_question == 5) {
            textbox = true;
          } else {
            textbox = false;
          }
          if (tap_question == which_question) {
            Get.defaultDialog(
              title: "${title_name[tap_question]} 질문을 하시겠습니까?",
              // middleText: "",
              //backgroundColor:
              // titleStyle:
              textConfirm: "네!",
              textCancel: "아니요!",
              confirmTextColor: onSurface[50],
              cancelTextColor: primary,
              buttonColor: primary,
              radius: 10,
              content: textbox
                  ? TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: '도움받고 싶은 내용을 입력하세요',
                ),
              )
                  : Text("Helper와 연결하려면 '네!'를 클릭해주세요"),
              onConfirm: () async {
                await NotificationService.sendNotification(
                  "${title_name[tap_question]} 관련 도움이 필요합니다.",
                  "지금 접속해서 도와주세요!!",
                  // FirebaseAuth.instance.currentUser!.uid
                );
                if (textbox) {
                  //기타 질문인지 아니면 카테고리화 되어 있는 질문인지
                  if (_textController.text.isNotEmpty) {
                    //기타 textfield에 질문내용 적었을
                    print(_textController.text);

                    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
                      //print("UID is Channel");
                      // await for camera and mic permissions before pushing video page
                      await _handleCameraAndMic(Permission.camera);
                      await _handleCameraAndMic(Permission.microphone);
                      // push video page with given channel name
                      String channel = FirebaseAuth.instance.currentUser!.uid;
                      await Get.off(() => CallPage_taker(
                        channelName: channel,
                        //  role: _role,
                      ));
                    }
                    //여기까지이
                  } else {
                    // 기타에 질문내용을 입력하지 않았을때 dialog 나
                    Get.defaultDialog(
                        title: "도움 입력하세요", middleText: "도움 입력하세요");
                  }
                } else {
                  // 카테고리화 되어 있는 것
                  //카테고리화 되어 있는 번호 tap_question
                  print(tap_question);

                  if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
                    //print("UID is Channel");
                    // await for camera and mic permissions before pushing video page
                    await _handleCameraAndMic(Permission.camera);
                    await _handleCameraAndMic(Permission.microphone);
                    // push video page with given channel name
                    await Get.off(() => CallPage_taker(
                      channelName: FirebaseAuth.instance.currentUser!.uid,
                      //  role: _role,
                    ));
                  }
                }
              },
            );
          }
        },
        child: ListWheelScrollView.useDelegate(
          controller: _scrollController,
          itemExtent: _itemHeight,
          physics: FixedExtentScrollPhysics(),
          overAndUnderCenterOpacity: 0.5,
          perspective: 0.002,
          onSelectedItemChanged: (index) {
            //다 움직이고 이거에 대한 번호를 같이 보내어서 필요한 도움이 필요하게 해야함
            print("이동 index: $index");
            which_question = index;
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) => _child(index),
            childCount: _itemCount,
          ),
        ),
      ),
    );
  }

  List<String> icon_name = [
    '58169',
    '57821',
    '58608', //'58214',
    '58280',
    '61894',
    '58123',
  ];
  List<String> title_name = [
    '전자기기',
    '교통',
    '해외',
    '한동학교생활',
    '가벼운 질문',
    '기타',
  ];
  List<String> subtitle_name = [
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
  ];

  Widget _child(int index) {
    return SizedBox(
      height: _itemHeight,
      child: ListTile(
        leading: Icon(
          IconData(
            int.parse("${icon_name[index]}"),
            fontFamily: 'MaterialIcons',
          ),
          color: primary[50],
          size: 50,
        ),
        title: Text(
          "${title_name[index]}",
          style: TextStyle(
            color: primary[50],
          ),
        ),
        subtitle: Text(
          "${subtitle_name[index]}",
          style: TextStyle(
            color: primary[50],
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Future<void> onJoin() async {
    //_channelController = homeController.user.uid;
    print("Uid(ChannelName): ${_channelController}");
    // update input validation
    // setState(() {
    //   _channelController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
    if (_channelController.isNotEmpty) {
      print("Not Empty");
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Get.off(() => CallPage_taker(
        channelName: _channelController,
        //role: _role,
      ));
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
