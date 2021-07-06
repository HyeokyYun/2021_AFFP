import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() => runApp(GetMaterialApp(home: Home()));

class Controller extends GetxController{
  var count1 = 0.obs;
  var count2 = 0.obs;
  increment1() => count1++;
  increment2() => count2++;
  decrement1() => count1--;
  decrement2() => count2--;
  int get sum => count1.value + count2.value;
}

class Home extends StatelessWidget {

  @override
  Widget build(context) {

    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final Controller c = Get.put(Controller());

    return Scaffold(
      // count가 변경 될 때마다 Obx(()=> 를 사용하여 Text()에 업데이트합니다.
        appBar: AppBar(title: Text("Adding App")),

        // 8줄의 Navigator.push를 간단한 Get.to()로 변경합니다. context는 필요없습니다.
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: ElevatedButton(
                child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
            GetX<Controller>(
              builder: (controller) {
                print("count 1 rebuild");
                return Text('Count1: ${controller.count1.value}');
              },
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: ElevatedButton(
                    child: Icon(Icons.add), onPressed: () => c.increment1())
                ),
                SizedBox(width: 10,),
                Center(child: ElevatedButton(
                    child: Icon(Icons.remove), onPressed: () => c.decrement1())
                ),
              ],
            ),
            GetX<Controller>(
              builder: (controller) {
                print("count 2 rebuild");
                return Text('Count2: ${controller.count2.value}');
              },
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: ElevatedButton(
                    child: Icon(Icons.add), onPressed: () => c.increment2())
                ),
                SizedBox(width: 10,),
                Center(child: ElevatedButton(
                    child: Icon(Icons.remove), onPressed: () => c.decrement2())
                ),
              ],
            ),
            GetX<Controller>(
              builder: (controller) {
                print("sum rebuild");
                return Text('Sum: ${controller.sum}');
              },
            ),
          ],
        ),

        // floatingActionButton:
        // FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment)
    );
  }
}

class Other extends StatelessWidget {
  // 다른 페이지에서 사용되는 컨트롤러를 Get으로 찾아서 redirect 할 수 있습니다.
  final Controller c = Get.find();

  @override
  Widget build(context){
    // 업데이트된 count 변수에 연결
    return Scaffold(body: Center(child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Sum is ${c.sum}"),
        Text("Count1 is  ${c.count1}"),
        Text("Count2 is  ${c.count2}"),
      ],
    )));
  }
}

