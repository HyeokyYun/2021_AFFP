import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_study1/models/Todo.dart';

class TodoController extends GetxController{
  var todos = <Todo>[].obs;

  @override
  void onInit(){
    List? storedTodos = GetStorage().read<List>('todos');

    if(!storedTodos.isNull){
      todos = storedTodos!.map((e) => Todo.fromJson(e)).toList().obs;
      //todos = RxList(storedTodos.map((e) => Todo.fromJson(e)).toList());
    }

    ever(todos, (_){
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}