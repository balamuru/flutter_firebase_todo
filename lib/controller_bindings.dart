import 'package:flutter_firebase_todo/controllers/todo_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<TodoController>(TodoController() );
  }
  
}