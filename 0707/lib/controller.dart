import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'model/list.dart';

class Controller extends GetxController {
  // final titleController = TextEditingController();
  // final authorController = TextEditingController();

  var books = <Book>[].obs;

  //final book = Book().obs;

  // void createText() {
  //   book.value.title = titleController.text.obs;
  //   book.value.author = authorController.text.obs;
  //   update(); // UI에게 변경사항 전
  // }
}

