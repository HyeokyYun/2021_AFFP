import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_study1/controllers/TodoController.dart';
import 'package:self_study1/models/Todo.dart';

class TodoScreen extends StatelessWidget {

  final TodoController todoController = Get.find();
  late final int? index; // 이거를 int?로 해줘야 HomeScreen에서 TodoScreen()여기 파라미터에 추가할때 null 사용가능!

  TodoScreen({this.index}); // 위에서 int?를 해주었기 때문에 required를 안해도 된다!

  @override
  Widget build(BuildContext context) {
    String text = '';
    if(!this.index.isNull){
      text = todoController.todos[index!].text; // 마지막으로 index에 null check 해줘야 함.
    }
    TextEditingController textEditingController = TextEditingController(
      text: text
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(36.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Whatdo you want to accomplish?',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none
                ),
                style: TextStyle(
                  fontSize: 25.0,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    if(this.index.isNull){
                      todoController.todos.add(
                          Todo(text: textEditingController.text)
                      );
                    }else{
                      var editing = todoController.todos[index!];
                      editing.text = textEditingController.text;
                      todoController.todos[index!] = editing;
                    }
                    Get.back();
                  },
                  child: Text((this.index.isNull) ? 'Add' : 'Edit'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
