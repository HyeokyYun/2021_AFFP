import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:circular_reveal_animation/circular_reveal_animation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home/home.dart';
import 'myPage/myPage.dart';
import 'testpage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  // final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  bool askIf = true;

  final widgetList = <Widget>[
    test1(),
    MyPage(),
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Color(0xFF373A36),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        // 0.5,
        0.3,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(milliseconds: 500),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        extendBody: true,
        //항목들
        body: askIf ? HomePage() : widgetList[_bottomNavIndex],
        //가운데 버튼
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: FloatingActionButton(
            elevation: 3,
            backgroundColor: Colors.grey[50],
            child: Container(
              height: 36,
              child: SvgPicture.asset(
                "assets/liveQ_logo.svg",
              ),
            ),
            onPressed: () {
              setState(() {
                askIf = true;
              });
              // _animationController.reset();
              // _animationController.forward();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //navigation bar
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: widgetList.length,
          tabBuilder: (int index, bool isActive) {
            final color;
            // index != 2
            // ?
            color = isActive ? Colors.grey[700] : Colors.grey[400];
            // : color = Colors.grey[400];
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset(
                    index == 0
                        ? "assets/bottomIcon1.svg"
                        : "assets/bottomIcon2.svg",
                    color: color,
                  ),
                ),
                // Icon(
                //   index == 0 ? Icons.ac_unit_rounded : Icons.person_outline,
                //   size: 28,
                //   color: color,
                // ),
              ],
            );
          },
          backgroundColor: Colors.grey[50],
          activeIndex: askIf ? 10 : _bottomNavIndex,
          splashColor: Colors.grey[50],
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(
            () {
              askIf = false;
              _bottomNavIndex = index;
            },
          ),
        ),
      ),
    );
  }
}
