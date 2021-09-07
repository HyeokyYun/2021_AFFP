import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:wegolego_jjinjjin_0907/agorafunc/call_helper.dart';
import 'package:wegolego_jjinjjin_0907/pages/login/login_controller.dart';

class ListPage extends StatefulWidget {
  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<ListPage> {

  ClientRole? _role = ClientRole.Audience;
  LoginPageController loginController = Get.find<LoginPageController>();
  String _displayText = 'Results go here';
  final _database = FirebaseDatabase.instance.reference();
  final uid = 'uid';

  @override
  void initState() {
    //  final FirebaseDatabase database = FirebaseDatabase(app: this.app);
    //  _uidRef = database.reference().child('Uids');

    super.initState();
    //  _activateListeners();
  }

  @override
  Widget build(BuildContext context) {
    //  final ref = referenceDatabase.reference();
    return Scaffold(
        appBar: AppBar(
          title: Text('Channel List'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [

                  StreamBuilder(
                      stream: _database
                          .child('Uids')
                          .orderByKey()
                      //.child('uid')
                          .limitToLast(10)
                          .onValue,
                      builder: (context, snapshot) {
                        final tilesList = <ListTile>[];
                        if (snapshot.hasData) {
                          final Channels = Map<String, dynamic>.from(
                              (snapshot.data! as Event).snapshot.value);
                          Channels.forEach((key, value) {
                            final nextchannel =
                            Map<String, dynamic>.from(value);
                            final uidTile = ListTile(
                                leading: Icon(Icons.favorite),
                                title: Text(nextchannel['uid']),
                                onTap: () => {
                                  Get.to(() => CallPage_helper(
                                    channelName: nextchannel['uid'],
                                    //role: _role,
                                  ))
                                }
                            );
                            tilesList.add(uidTile);
                          });
                        }
                        return Expanded(child: ListView(children: tilesList));
                      })
                ],
              )),
        ));
  }
}