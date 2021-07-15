import 'package:des_dev_camp2021/Widget/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //return GetBuilder<DashboardController>(
    //    builder: (controller) {
    return Scaffold(
      backgroundColor: Color(0xffe5ddca),
      appBar: AppBar(
        title: Text(
          '무물',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.logout), onPressed: () {
          Get.toNamed('/login');
        },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), onPressed: () {

          },
          ),
        ],
        backgroundColor: Color(0xffe5ddca),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                    ),
                  ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xffe5ddca),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.teal,
          elevation: 2.0,
          items: [

            _bottomNavigationBarItem(
              icon: CupertinoIcons.archivebox,
              label: 'board',
            ),
            _bottomNavigationBarItem(
              icon: CupertinoIcons.home,
              label: 'Home',
            ),
            _bottomNavigationBarItem(
              icon: CupertinoIcons.person,
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
  //  );
  // }

  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}