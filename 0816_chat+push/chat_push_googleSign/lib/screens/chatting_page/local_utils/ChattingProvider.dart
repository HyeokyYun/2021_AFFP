import 'package:chat_0816/models/ChattingModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// 변화되는 것을 ChangeNotifier로 바로 보내주는 역할.
class ChattingProvider extends ChangeNotifier{

  static const String CHATTING_ROOM = 'CHATTING_ROOM';

  ChattingProvider(this.pk, this.name); // 함수 안에 personal key와 name 인자를 입력하게 한다.
  final String pk;
  final String name;

  var chattingList = <ChattingModel>[];

  Stream<QuerySnapshot> getSnapshot(){
    final f = FirebaseFirestore.instance;
    return f.collection(CHATTING_ROOM).limit(1).orderBy('uploadTime', descending: true).snapshots();
  }
  void addOne(ChattingModel model){
    chattingList.insert(0, model);
    notifyListeners();
  }

  Future load() async {
    var now = DateTime.now().millisecondsSinceEpoch;
    final f = FirebaseFirestore.instance;
    var result = await f.collection(CHATTING_ROOM).where('uploadTime', isGreaterThan: now).orderBy('uploadTime', descending: true).get();
    var l = result.docs.map((e) => ChattingModel.fromJson(e.data())).toList(); // ChattingModel의 데이터를 e.data로 받고, toList로 저장하게 해준다.
    chattingList.addAll(l);
    notifyListeners();
  }
  
  Future send(String text) async {
    var now = DateTime.now().millisecondsSinceEpoch;
    final f = FirebaseFirestore.instance;
    await f.collection(CHATTING_ROOM).doc(now.toString()).set(ChattingModel(pk, name, text, now).toJson());
  }
}