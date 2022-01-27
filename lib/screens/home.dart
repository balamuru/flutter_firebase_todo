// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_todo/controllers/todo_controller.dart';
// import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_firebase_todo/controllers/todo_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();
    final _formKey = GlobalKey<FormState>();

    return const Scaffold(
      body: Center(
          child: Text("home!!")
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,//() => todoController.addTodo("task", false),
        label: const Text('Add Todo'),
        icon: const Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.green,
      ),

    );
  }
}
