import 'package:get/get.dart';
import 'package:self_study1/models/Todo.dart';

class TodoController extends GetxController{
  var todos = <Todo>[].obs;

  // factory Todo.fromJson(Map<String, dynamic> json) => Todo(
  //   text: json['text'],
  //   done: json['done']
  // );
}