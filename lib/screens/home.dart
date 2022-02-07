// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_todo/controllers/todo_controller.dart';
// import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_firebase_todo/controllers/todo_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          todoController.getData(); //refresh

          return Scaffold(
            body: Center(
              child: todoController.isLoading
                  ? Text('loading tasks ..') //print statement
                  : ListView.builder(
                      itemCount: todoController.taskList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Checkbox(
                            value: todoController.taskList[index].isDone,
                            onChanged: (value) {
                               todoController.setDoneTask(
                                  todoController.taskList[index].id, !todoController.taskList[index].isDone);
                            },
                            
                          ),
                          
                          title: Text(
                              todoController.taskList[index].task,
                          style: TextStyle (
                              decoration: todoController.taskList[index].isDone ?
                              TextDecoration.lineThrough :TextDecoration.none,
                            color: todoController.taskList[index].isDone ? Colors.grey : Colors.black
                          ),
                          ),

                          trailing: SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      if (!todoController
                                          .taskList[index].isDone) {
                                        await addOrEditTaskDialog(
                                            todoController,
                                            'Update Todo',
                                            todoController.taskList[index].id,
                                            todoController
                                                .taskList[index].task);
                                      }
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: todoController.taskList[index].isDone ? Colors.grey : Colors.blue,
                                  ),
                                  IconButton(
                                    onPressed: () => todoController.deleteTask(
                                        todoController.taskList[index].id),
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              )),
                        );
                      }),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async =>
                  await addOrEditTaskDialog(todoController, 'Add Todo', '', ''),
            ),
          );
        });
  }

  addOrEditTaskDialog(TodoController todoController, String title, String id,
      String task) async {
    if (task.isNotEmpty) {
      _taskController.text = task;
    }

    Get.defaultDialog(
      title: title,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _taskController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Cannot be empty';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await todoController.addOrEditTodo(
                    _taskController.text.trim(), false, id);
                _taskController.clear();
                Get.back();
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
