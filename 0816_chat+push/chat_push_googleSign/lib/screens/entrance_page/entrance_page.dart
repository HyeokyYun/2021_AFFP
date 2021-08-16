import 'package:chat_0816/screens/chatting_page/chatting_page.dart';
import 'package:chat_0816/screens/chatting_page/local_utils/ChattingProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EntrancePage extends StatefulWidget {
  const EntrancePage({Key? key}) : super(key: key);

  @override
  _EntrancePageState createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: TextStyle(
                fontSize: 25,
              ),
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'User Name',
                  hintStyle: TextStyle(color: Colors.grey.shade400)),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              var uuid = Uuid().v1(); // random uid 생성.
              print('uuid > $uuid');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => ChattingProvider(uuid, _controller.text), // create를 통해 바뀌는 것을 보여주는 듯...?
                        child: ChattingPage(),
                      )));
              final f = FirebaseFirestore.instance;
              f.collection('Profile').doc('abc').set(
                  {'abc??': 'bcdcd'}); // collection은 그룹, doc은 고유의 key값 like DNA
              print("Finished?");
            },
            child: Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Enter Room',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
