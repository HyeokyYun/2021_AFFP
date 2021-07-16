import 'package:des_dev_camp2021/Screen/home.dart';
import 'package:des_dev_camp2021/Screen/mypage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'board.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 1;

  final List<Widget> _children = [QuestionBoardPage(), HomePage(), MyPage()];
  void _onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffe5ddca),
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.archivebox),
              label: "QnA"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
          label: "Home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),
              label: "Account"),
        ],
      ),
    );
  }
}
