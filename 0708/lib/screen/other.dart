import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ex/controllers/counterController.dart';

class OtherScreen extends StatelessWidget {
  final CounterController _counterController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text('Screen was clicked ${_counterController.counter.value} times')),
          SizedBox(height: 10),
          ElevatedButton(onPressed: (){
            Get.back();
          }, child: Text("Open Other Screen"),)
        ],
      ),
    );
  }
}
