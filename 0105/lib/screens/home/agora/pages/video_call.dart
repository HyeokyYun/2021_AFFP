//video call list 생성하기

import 'package:flutter/material.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List"),
      ),
    );
  }
}
