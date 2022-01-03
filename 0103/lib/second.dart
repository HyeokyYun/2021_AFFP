import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen",
        style: TextStyle(color: Colors.red, fontSize: 40),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Second Screen started!',
              style: TextStyle(color: Colors.green, fontSize: 40),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
