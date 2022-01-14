import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegolego_v015/screens/agora/pages/pie_chart.dart';
import 'package:wegolego_v015/screens/agora/utils/settings.dart';
import 'package:wegolego_v015/screens/pages/home.dart';
import '../../../config.dart';
import 'heart.dart';
import 'dart:math' as math;
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class CallPage_taker extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? channelName;
  const CallPage_taker({Key? key, this.channelName}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage_taker> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool videoOnOff = false;
  bool _helperIn = false;
  late RtcEngine _engine;
  int? streamId;
  Offset change = const Offset(0, 0);
  bool heart = false;
  late String is_user;
  bool check = true;

  //원 그리기 변수
  late Timer timer;
  final bool _isPlaying = false;
  var value = 0;
  Offset? location;
  late double subtract;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? get userProfile => auth.currentUser;
  User? currentUser;

  var firebaseUser = FirebaseAuth.instance.currentUser;

  //bool isLoading = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();

    streamId = await _engine.createDataStream(false, false);

    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    //configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(null, widget.channelName!, null, 0);
    _engine.switchCamera();
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.Communication);
    //만약에 1to1으로 만들려면 LiveBroadcasting이거 대신에 Communication으로 넣으면 일대일이 가능해짐
    //await _engine.setClientRole(ClientRole.Broadcaster);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
          print("error occur plz check it $_infoStrings");
          print("error occur plz check it $_infoStrings");
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
        is_user = uid.toString();
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
        if (check) {
          check = false;
        } else {
          _engine.sendStreamMessage(streamId!, is_user);
        }
      },
      userOffline: (uid, elapsed) {
        setState(() {
          final info = 'userOffline: $uid';
          _infoStrings.add(info);
          _users.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'firstRemoteVideo: $uid ${width}x $height';
          _infoStrings.add(info);
        });
      },
      streamMessage: (_, __, _coordinates) {
        //final String coordinate = "$message";
        late String first;
        late String second;
        late double d1;
        late double d2;
        // if (_coordinates.compareTo('erase') == 0) {
        // } else if (_coordinates.compareTo('end') == 0) {
        //   //Navigator.pop(context);
        // }
        if (_coordinates.compareTo('end') == 0) {
          FirebaseFirestore.instance
              .collection('videoCall')
              .doc(firebaseUser!.uid)
              .delete();
          Get.offAll(() => Home());
          // Navigator.pop(context);
        } else {
          subtract = (MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.width / 3 * 4)) /
              2;
          first = _coordinates.substring(0, _coordinates.indexOf(' '));
          second = _coordinates.substring(
              _coordinates.indexOf(' '), _coordinates.indexOf('a'));
          d1 = double.parse(first);
          d2 = double.parse(second);
          change = Offset(d1 * MediaQuery.of(context).size.width,
              d2 * MediaQuery.of(context).size.width / 3 * 4 + subtract);
          setState(() {
            value = 0;
            timer = Timer.periodic(const Duration(milliseconds: 3), (t) {
              setState(() {
                if (value < 100) {
                  value++;
                } else {
                  timer.cancel();
                }
              });
            });
          });
        }
      },
      streamMessageError: (_, __, error, ___, ____) {
        final String info = "here is the error $error";
        print(info);
      },
    ));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    //if (widget.role == ClientRole.Broadcaster) {}
    list.add(RtcLocalView.SurfaceView(
      renderMode: VideoRenderMode.FILL,
    ));
    for (var uid in _users) {
      list.add(RtcRemoteView.SurfaceView(
        uid: uid,
        renderMode: VideoRenderMode.FILL,
      ));
    }
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: view);
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
      //_engine.switchCamera();
        return Stack(
          children: [
            _videoView(views[0]),
            _connecting(),
          ],
        );
      case 2:
        _helperIn = true;
        const CircularProgressIndicator();
        return Stack(
          children: <Widget>[
            _videoView(views[0]),
          ],
        );
      default:
    }
    return Container();
  }

  Widget _connecting() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
              "https://i.ibb.co/nsVhXLq/black-background.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _turnoffcamera() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://i.ibb.co/nsVhXLq/black-background.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "카메라가 꺼져있습니다\nCamera is off",
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Helper와 음성으로 도움을 받으세요!\nGetting a help with the voice",
              style: TextStyle(
                color: Color(0xff979797),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    //if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _helperIn
              ? RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              videoOnOff ? Icons.videocam_off : Icons.videocam,
              color: videoOnOff ? Colors.white : Colors.blueAccent,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: videoOnOff ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
              : RawMaterialButton(
            onPressed: () {},
            child: const Icon(
              Icons.videocam,
              color: Colors.blueAccent,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          _helperIn
              ? RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
              : RawMaterialButton(
            onPressed: () {},
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 4.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),

          heart
              ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: MaterialButton(
              minWidth: 0,
              onPressed: () async {},
              child: const Icon(
                Icons.favorite,
                color: Color(0xffe82b50),
                size: 35.0,
              ),
              padding: const EdgeInsets.all(12.0),
            ),
          )
              : Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: MaterialButton(
              minWidth: 0,
              onPressed: () async {
                popUp();
                await _engine.sendStreamMessage(streamId!, "heart");
              },
              child: const Icon(
                Icons.favorite,
                color: Color(0xffe82b50),
                size: 35.0,
              ),
              padding: const EdgeInsets.all(12.0),
            ),
          ),
          //if (heart == true) heartPop(),
        ],
      ),
    );
  }

  //Love animation
  final _random = math.Random();
  late Timer _timer;
  double height = 0.0;
  final int _numConfetti = 10;
  var len;
  bool accepted = false;
  bool stop = false;
  //bool heart = false;

  void popUp() async {
    setState(() {
      heart = true;
    });
    Timer(
        const Duration(seconds: 4),
            () => {
          _timer.cancel(),
          setState(() {
            heart = false;
          })
        });
    _timer = Timer.periodic(const Duration(milliseconds: 125), (Timer t) {
      setState(() {
        height += _random.nextInt(20);
      });
    });
  }

  Widget heartPop() {
    final size = MediaQuery.of(context).size;
    final confetti = <Widget>[];
    for (var i = 0; i < _numConfetti; i++) {
      final height = _random.nextInt(size.height.floor());
      //final width = 0;
      confetti.add(HeartAnim(
        height % 300.0,
        //width.toDouble(),
        1,
      ));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          //height: 400,
          width: (MediaQuery.of(context).size.width) / 2,
          child: Stack(
            children: confetti,
          ),
        ),
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return const Text(
                    "null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    FirebaseFirestore.instance
        .collection('videoCall')
        .doc(firebaseUser!.uid)
        .delete();

    _engine.sendStreamMessage(streamId!, "end");
    Get.offAll(() => Home());
    // Navigator.pop(context);
    // Get.back();
    // Get.off(
    //   Thank(),
    //   transition: Transition.native,
    // );
    //Get.defaultDialog();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
      print(muted);
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.sendStreamMessage(streamId!, "onoffVideo");
    setState(() {
      videoOnOff = !videoOnOff;
    });
  }

  Widget circleDrawing(BuildContext context) {
    // location = Offset(MediaQuery.of(context).size.width / 2,
    //     MediaQuery.of(context).size.height / 2);
    return Stack(
      children: [
        CustomPaint(
          size: Size(Config.screenWidth! * 0.2, Config.screenWidth! * 0.2),
          painter: PieChart(
            percentage: value,
            location: change,
          ),
        ),
      ],
    );
  }

  Widget voiceOff(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: Config.screenHeight! * 0.2,
          ),
          const Text(
            "음성이 꺼져 있습니다.\nVoice is off",
            style: TextStyle(
              color: Colors.red,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: videoOnOff
            ? Center(
          child: Stack(
            children: <Widget>[
              _turnoffcamera(),
              if (heart == true) heartPop(),
              // _panel(),
              muted ? voiceOff(context) : Container(),
              _toolbar(),
            ],
          ),
        )
            : Center(
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 3 * 4,
                  child: _viewRows(),
                ),
              ),
              if (heart == true) heartPop(),
              // _panel(),
              muted ? voiceOff(context) : Container(),
              circleDrawing(context),
              _toolbar(),
            ],
          ),
        ));
  }
}