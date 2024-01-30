// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/todo_provider.dart';
import 'package:quiz_app/view/add_page.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo here,'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: value.items.length,
              itemBuilder: (context, index) {
                final todoModel = value.items[index];
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(todoModel.title!),
                  subtitle: Text(todoModel.description!),
                  trailing: PopupMenuButton(onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddPage(todoModel: todoModel)));
                    } else if (value == 'delete') {
                      Provider.of<TodoProvider>(context, listen: false)
                          .deleteById(todoModel.id!);
                    }
                  }, itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        child: Text('Edit'),
                        value: 'edit',
                      ),
                      PopupMenuItem(
                        child: Text('delete'),
                        value: 'delete',
                      )
                    ];
                  }),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPage()));
        },
        label: Text('ADD TODO'),
      ),
    );
  }
}
