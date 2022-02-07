import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_todo/models/task_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var isLoading = false;
  var taskList = <TaskModel>[];

  Future<void> addTodo(String task, bool isDone, String id) async {
    await FirebaseFirestore.instance.collection("todos")
        .doc(id != '' ? id : null)
        .set(
        {"task": task, "isDone": isDone},
        SetOptions(merge: true)).then((value) => getData());
  }

  Future<void> getData() async {
    try {
      QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
              .collection("todos")
              .orderBy("task")
              .get();

      taskList.clear();
      for (var doc in taskSnapshot.docs) {
            //note that we use doc.id to indicate an integral part of the document
            //and not an attribute
            taskList.add(TaskModel(doc.id, doc["task"], doc["isDone"]));
          }
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance
        .collection("todos")
        .doc(id)
        .delete();
  }

  Future<void> markDoneTask(String id) async{
    await FirebaseFirestore.instance.collection("todos")
        .doc(id != '' ? id : null)
        .set(
        { "isDone": true},
        SetOptions(merge: true)).then((value) => getData());
  }
}
