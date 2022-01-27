import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Future<void> addTodo(String task, bool isDone) async {
    await FirebaseFirestore.instance
        .collection("todos")
        .doc()
        .set({"task": task, "isDone": isDone},
        SetOptions(merge: true));
  }
}
