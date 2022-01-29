import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_todo/models/task_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var isLoading = false;
  var taskList = <TaskModel>[];

  Future<void> addTodo(String task, bool isDone) async {
    await FirebaseFirestore.instance.collection("todos").doc().set(
        {"task": task, "isDone": isDone},
        SetOptions(merge: true)).then((value) => Get.back());
  }

  Future<void> getData() async {
    try {
      QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
              .collection("todos")
              .orderBy("task")
              .get();

      taskList.clear();
      for (var doc in taskSnapshot.docs) {
            taskList.add(TaskModel(doc["task"], doc["isDone"]));
          }
      isLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }
}
