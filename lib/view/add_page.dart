// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: AppBar(
        title: const Text(
          'Add here, ',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w200),
        ),
        backgroundColor: Colors.indigo[300],
        elevation: 10,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.grey[400])),
            maxLines: 8,
            minLines: 5,
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () => submitData(context), child: const Text('Save'))
        ],
      ),
    );
  }

  Future<void> submitData(BuildContext context) async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final Url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(Url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      print('Saved');
      successMessage(context, 'Saved');
    } else {
      errorMessage(context, 'Failed');
    }
  }

  void successMessage(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void errorMessage(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: Colors.red[200],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
