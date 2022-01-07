import 'package:wegolego_v014/screens/home/agora/pages/call_helper.dart';
import 'package:wegolego_v014/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../config.dart';

class ChannelList extends StatefulWidget {
  const ChannelList({Key? key}) : super(key: key);

  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('videoCall')
        .orderBy("timeRegister")
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('LivQ',
                  style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.white,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('LivQ',
                style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.white,
              leading: const BackButton(
                color: Colors.black,
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return Card(
                          child: ListTile(
                            title: Text(data['name'],
                              style: TextStyle(
                                  fontSize: Config.screenWidth! * 0.06),
                            ),
                            isThreeLine: true,
                            //Text(data['uid']),
                            subtitle: TextButton(
                              child: Text(
                                "Join The Room",
                                //data['uid'],
                                style: TextStyle(
                                  fontSize: Config.screenWidth! * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff3F5A49)
                                ),
                              ),
                              onPressed: () {
                                Get.to(()=>CallPage_helper(channelName: data['uid'],));
                              },
                            ),
                          ),
                        );
                      }).toList(),
                      // children: _buildGridCards(context),
                    ),
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
          );
        });
  }
}
