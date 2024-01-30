// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:quiz_app/model/todo_model.dart';
import 'package:quiz_app/service/todo_service.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    fetchTodo();
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  List<TodoModel> items = [];
  bool isEdit = false;
  TodoServices todoServices = TodoServices();

  Future<void> SubmitData() async {
    final title = titleController.text;
    final description = DescriptionController.text;
    final requestModel =
        TodoModel(title: title, description: description, iscompleted: false);

    await todoServices.SubmitData(requestModel);
    titleController.text = '';
    DescriptionController.text = '';
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    items = await todoServices.fetchTodo();
    notifyListeners();
  }

  Future<void> deleteById(String id) async {
    await todoServices.deleteById(id);
    items.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  Future<void> updateData(TodoModel todoModel) async {
    final id = todoModel.id;
    final title = titleController.text;
    final description = DescriptionController.text;
    final requestModel = TodoModel(
        id: id, title: title, description: description, iscompleted: false);

    try {
      await todoServices.updateData(requestModel, id);
      fetchTodo();
    } catch (e) {
      throw Exception('update :$e');
    }
  }

  void isEditValueChange(bool value) {
    isEdit = value;
  }
}
