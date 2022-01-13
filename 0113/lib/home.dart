import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wegolego_v015/push_notification_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController textEditingController = TextEditingController();

  String? _token;
  late FirebaseMessaging messaging;

  @override
  void initState() {
    // TODO: implement initState
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      _token = value;
      print("Auth token: $_token");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Input'
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await NotificationService.sendNotification("뭐하냐", "되는거 맞아?");
              },
              child: const Text("Send"),
            ),
          ),
        ],
      ),
    );
  }
}
