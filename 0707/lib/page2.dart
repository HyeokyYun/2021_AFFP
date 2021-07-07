import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class Page2 extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Title is ${c.books.value}',
          style: TextStyle(
            color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 20
          ),
        ),
      ),
    );
  }
}
