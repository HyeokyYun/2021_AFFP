import 'package:flutter/material.dart';
import 'package:self_study1/controllers/TodoController.dart';
import 'package:get/get.dart';
import 'package:self_study1/models/Todo.dart';
import 'package:self_study1/screens/TodoScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(TodoScreen(index: null,));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Obx(
            () => ListView.separated(
                itemBuilder: (context, index) => Dismissible(
                  key: UniqueKey(),
                  onDismissed: (_){
                    var removed = todoController.todos[index];
                    todoController.todos.removeAt(index);
                    Get.snackbar('Task removed', 'The task "${removed.text}" was successfully removed.',
                    mainButton: TextButton(
                      style: TextButton.styleFrom(
                        //backgroundColor: Colors.white,
                        primary: Colors.black
                      ),
                      child: Text('Undo'),
                      onPressed: (){
                        if(removed.isNull){
                          return;
                        }
                        todoController.todos.insert(index, removed);
                        if(Get.isSnackbarOpen!){
                          Get.back();
                        }
                      },
                    ));
                  },
                  child: ListTile(
                    title: Text(
                      todoController.todos[index].text,
                      style: (todoController.todos[index].done) ?
                      TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough
                      ):
                      TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color
                      ),
                    ),
                    onTap: (){
                      Get.to(
                        TodoScreen(
                        index: index,
                        )
                      );
                    },
                    leading: Checkbox(
                      value: todoController.todos[index].done,
                      onChanged: (v){
                        var changed = todoController.todos[index];
                        changed.done = v!;
                        todoController.todos[index] = changed;
                      },
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                separatorBuilder: (_, __) => Divider(),
                itemCount: todoController.todos.length
            ),
        ),
      ),
    );
  }
}
